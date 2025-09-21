import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/services/player.dart';
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
  AddListenApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super(
        AddListenApiRequest(),
        AddListenApiResponse(),
        'api/listen/add',
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
       _authUser = authUser,
       _episodeDatabase = EpisodeDatabase(databaseService);

  final AddListenApiServer _addServer;
  final ListenDatabase _database;
  final EpisodeDatabase _episodeDatabase;
  final AuthUser _authUser;

  final Map<String, UserListen> _listens = {};

  Future<void> init() async {
    _log.info('Initializing ListenApi...');
    _listens.clear();
    // This should try the db and server..
    var result = await sync();
    switch (result) {
      case ApiOk():
        var subscription = result.value;

        for (final sub in subscription) {
          _listens[sub.episodeId] = sub;
        }
      case ApiError():
        _log.warning('Failed to load listens: ${result.error}');
    }
  }

  UserListen? get(String episodeId) => _listens[episodeId];

  Future<ApiResult<Iterable<UserListen>>> list() async {
    // Do I need to check with the server?
    try {
      var result = await _database.list();
      return ApiResult.ok(result);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<Iterable<UserListen>>> sync() async {
    var result = await list();
    // TODO(duncanwood): Sync with the server
    return result;
  }

  UserListen _createListen(String episodeId, PlayerProgress progress) {
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
    Episode episode,
    PlayerProgress progress, {
    bool server = true,
  }) async {
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
  const ListensApi({
    required AuthUser authUser,
    required GetEpisodeApi episodeApi,
  }) : _authUser = authUser,
       _episodeApi = episodeApi;

  final AuthUser _authUser;
  final GetEpisodeApi _episodeApi;

  Future<ApiResult<Iterable<Episode>>> get() async {
    var listenApi = _authUser.listenApi;
    var result = await listenApi.list();
    _log.info('got $result');
    switch (result) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(result.error);
    }

    var listens = result.value;
    var episodeIds = listens.map((s) => s.episodeId);
    _log.info('for episodeIds: ${episodeIds.length}');
    var episodeResult = await _episodeApi.getMany(episodeIds);
    _log.info('got $episodeResult');

    switch (episodeResult) {
      case ApiOk():
        break;
      case ApiError():
        return ApiResult.error(episodeResult.error);
    }

    return ApiResult.ok(episodeResult.value);
  }
}
