import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/services/player/audio_handler.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/listens.dart';

Logger _log = Logger('api/listens');

class AddListenApiRequest extends ApiRequest<AddListenMessage_Request> {
  AddListenApiRequest()
    : super(AddListenMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class AddListenApiResponse extends ApiResponse<AddListenMessage_Response> {
  AddListenApiResponse() : super(AddListenMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class AddListenApiServer
    extends ServerApi<AddListenApiRequest, AddListenApiResponse> {
  AddListenApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         AddListenApiRequest(),
         AddListenApiResponse(),
         'api/listens/add',
         client: client,
         authUser: authUser,
       );
}

class ListListenApiRequest extends ApiRequest<ListListenMessage_Request> {
  ListListenApiRequest({String? userId, bool? includeEpisodes})
    : super(
        ListListenMessage_Request(
          userId: userId,
          includeEpisodes: includeEpisodes,
          requestInfo: RequestInfo(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
}

class ListListenApiResponse extends ApiResponse<ListListenMessage_Response> {
  ListListenApiResponse() : super(ListListenMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  QueryCursor? get cursor =>
      responsePb.hasCursor()
          ? QueryCursor.fromMessage(responsePb.cursor)
          : null;
  Iterable<UserListen> get listens =>
      responsePb.listens.map((l) => UserListen.fromMessage(l));
}

class ListListenApiServer
    extends ServerApi<ListListenApiRequest, ListListenApiResponse> {
  ListListenApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         ListListenApiRequest(),
         ListListenApiResponse(),
         'api/listens/list',
         client: client,
         authUser: authUser,
       );
}

class ListenApi {
  ListenApi({
    required AbstractHttpService httpService,
    required AuthUser authUser,
    required AbstractDatabaseService databaseService,
  }) : _addServer = AddListenApiServer(authUser: authUser, client: httpService),
       _database = ListenDatabase(databaseService),
       _syncServer = SyncListenApiServer(
         authUser: authUser,
         client: httpService,
       ),
       _authUser = authUser,
       _episodeDatabase = EpisodeDatabase(databaseService);

  static final ListenApi instance = ListenApi(
    authUser: AuthUser.instance,
    httpService: HttpService.instance,
    databaseService: DatabaseService.instance,
  );

  final AddListenApiServer _addServer;
  final ListenDatabase _database;
  final EpisodeDatabase _episodeDatabase;
  final AuthUser _authUser;
  final SyncListenApiServer _syncServer;

  final Map<String, UserListen> _listens = {};

  Future<void> init() async {
    _log.info('Initializing ListenApi...');
    _listens.clear();
    // This should try the db and server..
    var result = await sync();
    switch (result) {
      case ApiOk():
        var subscription = result.value;

        // Add the listens in memory
        for (final sub in subscription) {
          _listens[sub.episodeId] = sub;
        }
      case ApiError():
        _log.warning('Failed to load listens: ${result.error}');
    }
  }

  UserListen? get(String episodeId) => _listens[episodeId];

  Future<ApiResult<Iterable<UserListen>>> list({User? user}) async {
    return await listLocal();
  }

  Future<ApiResult<Iterable<UserListen>>> listLocal({User? user}) async {
    try {
      var result = await _database.list();
      var resultList = result.toList();
      resultList.sort((a, b) {
        // Sort by listen timestamp, latest first
        // TODO(duncan): Do this in the database
        return b.listenTimestamp.compareTo(a.listenTimestamp);
      });

      // _log.info('LISTEN TIMESTAMPS: ${result.map((e) => e.listenTimestamp)}');
      return ApiResult.ok(resultList);
    } on Exception catch (e) {
      _log.warning(e);
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<Iterable<UserListen>>> sync() async {
    var result = await listLocal();
    switch (result) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(result.error);
    }

    var listens = result.value;
    var request = SyncListenApiRequest(listens: listens);
    var response = SyncListenApiResponse();
    try {
      await _syncServer.execute(request, response);
      // log to database
      // await _subscriptionDatabase.clear();
      listens = response.listens;
      // add the podcast messages
      for (var sub in listens) {
        if (sub.episode != null) {
          // remove the podcast and add to db.
          _log.info("adding episode ${sub.episode!.id}");
          await _episodeDatabase.put(sub.episode!);
          sub.dropEpisode();
        }
      }
      await _database.putAll(listens);
      _log.info('Synced ${listens.length} subscriptions');
      return ApiResult.ok(listens);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  UserListen _createListen(
    String episodeId,
    AudioHandlerServiceEpisodeState progress,
  ) {
    if (!_authUser.isSignedIn) throw UserNotSignedInError();
    return UserListen(
      id: '${_authUser.user!.id}-$episodeId',
      userId: _authUser.user!.id,
      episodeId: episodeId,
      listenTimestamp: DateTime.now(),
      seconds: progress.progressDuration,
      completed: progress.completed,
    );
  }

  // We have to make sure the episode is in the local DB when
  // registering a listen, so just keep a log of puts
  // so we can skip always adding the episode to the local DB.
  Map<String, bool> _episodePuts = {};

  Future<ApiResult<UserListen>> add(
    AudioHandlerServiceEpisodeState progress, {
    bool server = true,
  }) async {
    _log.info('add listen');
    var episode = progress.episode;
    String episodeId = episode.id;
    UserListen listen;
    // Add to DB
    try {
      // Note you need to make sure the episode is in the local DB
      // This gets called a lot, maybe I need caching or something
      if (_episodePuts[episodeId] == null) {
        _episodeDatabase.put(episode);
        _episodePuts[episodeId] = true;
      }

      listen = _createListen(episodeId, progress);
      await _database.put(listen);
      _listens[episodeId] = listen;
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
    if (!server) return ApiResult.ok(listen);
    // Then to server
    try {
      var request = AddListenApiRequest();
      request.requestPb.listen = listen.toMessage();
      var response = AddListenApiResponse();
      await _addServer.execute(request, response);
      listen = UserListen.fromMessage(response.responsePb.listen);
      return ApiResult.ok(listen);
    } on Exception catch (e) {
      _log.info('server error $e');
    }
    // Then respond
    return ApiResult.ok(listen);
  }
}

class ListensApi {
  ListensApi({
    required AuthUser authUser,
    required GetEpisodeApi episodeApi,
    required AbstractHttpService httpService,
  }) : _authUser = authUser,
       _episodeApi = episodeApi,
       _listServer = ListListenApiServer(
         authUser: authUser,
         client: httpService,
       );

  final AuthUser _authUser;
  final ListListenApiServer _listServer;
  final GetEpisodeApi _episodeApi;

  Future<IterableApiResult<Iterable<UserListen>>> listForUser(
    String userId, {
    QueryCursor? cursor,
  }) async {
    var user = _authUser.user;

    if (user != null && user.id == userId) {
      var result = await get();
      switch (result) {
        case ApiOk():
          return IterableApiResult.ok(result.value);
        case ApiError():
          return IterableApiResult.error(result.error);
      }
    }

    var request = ListListenApiRequest(userId: userId, includeEpisodes: true);
    var response = ListListenApiResponse();
    try {
      await _listServer.execute(request, response);
      return IterableApiResult.ok(
        response.listens,
        next:
            response.cursor != null
                ? () => listForUser(userId, cursor: response.cursor)
                : null,
      );
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }

  Future<ApiResult<Iterable<UserListen>>> get() async {
    var listenApi = ListenApi.instance;
    var result = await listenApi.listLocal();
    switch (result) {
      case ApiOk():
        break;
      case ApiError():
        _log.warning(result.error);
        return ApiResult.error(result.error);
    }

    var listens = result.value;
    var episodeIds = listens.map((s) => s.episodeId);
    var episodeResult = await _episodeApi.getMany(episodeIds);

    switch (episodeResult) {
      case ApiOk():
        break;
      case ApiError():
        _log.warning(episodeResult.error);
        return ApiResult.error(episodeResult.error);
    }
    Map<String, Episode> episodeMap = {};
    for (var episode in episodeResult.value) {
      episodeMap[episode.id] = episode;
    }
    return ApiResult.ok(
      listens.map((l) {
        var episode = episodeMap[l.episodeId];
        if (episode == null) return l;
        return l.copyWithEpisode(episode);
      }),
    );
  }
}

class SyncListenApiRequest extends ApiRequest<SyncListenMessage_Request> {
  SyncListenApiRequest({Iterable<UserListen>? listens})
    : super(
        SyncListenMessage_Request(
          requestInfo: RequestInfo(),
          listens: listens?.map((s) => s.toMessage()).toList(),
        ),
      );

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class SyncListenApiResponse extends ApiResponse<SyncListenMessage_Response> {
  SyncListenApiResponse() : super(SyncListenMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  Iterable<UserListen> get listens =>
      responsePb.listens.map((s) => UserListen.fromMessage(s));
}

class SyncListenApiServer
    extends ServerApi<SyncListenApiRequest, SyncListenApiResponse> {
  SyncListenApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SyncListenApiRequest(),
         SyncListenApiResponse(),
         'api/listens/sync',
         authUser: authUser,
         client: client,
       );
}
