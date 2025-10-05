import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart' hide QueryCursor;
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/podcast.dart';

Logger _log = Logger('api/podcast');

class GetPodcastApiRequest extends ApiRequest<GetPodcastMessage_Request> {
  GetPodcastApiRequest()
    : super(GetPodcastMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class GetPodcastApiResponse extends ApiResponse<GetPodcastMessage_Response> {
  GetPodcastApiResponse() : super(GetPodcastMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  void fromPodcastBuffer(Uint8List buffer) {
    responsePb.mergeFromBuffer(buffer);
  }
}

class GetPodcastApiServer
    extends ServerApi<GetPodcastApiRequest, GetPodcastApiResponse> {
  GetPodcastApiServer({AbstractHttpService? client, required AuthUser authUser})
    : super(
        GetPodcastApiRequest(),
        GetPodcastApiResponse(),
        'api/podcast/get',
        authUser: authUser,
        client: client,
      );
}

class ListPodcastEpisodesApiRequest
    extends ApiRequest<ListPodcastEpisodesMessage_Request> {
  ListPodcastEpisodesApiRequest()
    : super(ListPodcastEpisodesMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class ListPodcastEpisodesApiResponse
    extends ApiResponse<ListPodcastEpisodesMessage_Response> {
  ListPodcastEpisodesApiResponse()
    : super(ListPodcastEpisodesMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class ListPodcastEpisodesApiServer
    extends
        ServerApi<
          ListPodcastEpisodesApiRequest,
          ListPodcastEpisodesApiResponse
        > {
  ListPodcastEpisodesApiServer({
    AbstractHttpService? client,
    required AuthUser authUser,
  }) : super(
         ListPodcastEpisodesApiRequest(),
         ListPodcastEpisodesApiResponse(),
         'api/podcast/list',
         authUser: authUser,
         client: client,
       );
}

class PodcastApi {
  PodcastApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
    required AuthUser authUser,
  }) : _server = GetPodcastApiServer(client: httpService, authUser: authUser),
       _database = PodcastDatabase(databaseService),
       // TODO(duncanwood): The upgrade function will be called twice!
       _episodeDatabase = EpisodeDatabase(databaseService),
       _listServer = ListPodcastEpisodesApiServer(
         client: httpService,
         authUser: authUser,
       ) {
    _log.info('PodcastApi created');
  }

  final GetPodcastApiServer _server;
  final ListPodcastEpisodesApiServer _listServer;
  final PodcastDatabase _database;
  final EpisodeDatabase _episodeDatabase;

  Future<IterableApiResult<Iterable<Episode>>> listEpisodesServer(
    String podcastId, {
    QueryCursor? cursor,
  }) async {
    _log.info('listEpisodesServer');
    var request = ListPodcastEpisodesApiRequest();
    var response = ListPodcastEpisodesApiResponse();

    // build request
    request.requestPb.podcastId = podcastId;
    if (cursor != null) {
      request.requestPb.cursor = cursor.toMessage();
    }

    try {
      await _listServer.execute(request, response);
      var episodes = response.responsePb.episodes.map(
        (e) => Episode.fromMessage(e),
      );
      // Update the cache
      await _episodeDatabase.putAll(episodes);
      return IterableApiResult.ok(
        episodes,
        next:
            () => listEpisodesServer(
              podcastId,
              cursor: QueryCursor.fromMessage(response.responsePb.cursor),
            ),
      );
    } on Exception catch (e) {
      return IterableApiResult.error(e);
    }
  }

  Future<IterableApiResult<Iterable<Episode>>> listEpisodesLocal(
    String podcastId, {
    QueryCursor? cursor,
  }) async {
    _log.info('listEpisodesLocal');
    try {
      var episodes = await _episodeDatabase.listFromPodcastId(podcastId);
      _log.info('returning ${episodes.length} episodes');
      return IterableApiResult.ok(episodes);
    } on DatabaseNotFoundException catch (e) {
      _log.info(e);
      return IterableApiResult.error(e);
    } on Exception catch (e) {
      _log.info(e);
      return IterableApiResult.error(e);
    }
  }

  Stream<IterableApiResult<Iterable<Episode>>> listEpisodes(
    String podcastId, {
    QueryCursor? cursor,
  }) async* {
    var didReturnLocal = false;
    var local = await listEpisodesLocal(podcastId, cursor: cursor);
    switch (local) {
      case ApiOkIterable():
        didReturnLocal = true;
        yield local;
      case ApiErrorIterable():
      // yield local;
    }
    var server = await listEpisodesServer(podcastId, cursor: cursor);
    switch (server) {
      case ApiOkIterable():
        yield server;
      case ApiErrorIterable():
        if (!didReturnLocal) {
          yield server;
        }
    }
  }

  Stream<ApiResult<Iterable<Episode>>> list(
    String podcastId, {
    QueryCursor? cursor,
  }) async* {
    _log.info('list');
    var request = ListPodcastEpisodesApiRequest();
    request.requestPb.podcastId = podcastId;
    if (cursor != null) {
      request.requestPb.cursor = cursor.toMessage();
    }
    var response = ListPodcastEpisodesApiResponse();
    var didReturnEpisodes = false;

    try {
      var episodes = await _episodeDatabase.listFromPodcastId(podcastId);
      yield ApiResult.ok(episodes);
      didReturnEpisodes = episodes.isNotEmpty;
    } on DatabaseNotFoundException catch (e) {
      // Do nothing - we will fetch from the server.
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }

    // TODO(duncan): I think you need to merge these two results..
    try {
      await _listServer.execute(request, response);
      var episodes = response.responsePb.episodes.map(
        (e) => Episode.fromMessage(e),
      );
      // Update the cache
      await _episodeDatabase.putAll(episodes);
      yield ApiResult.ok(episodes);
    } on Exception catch (e) {
      if (!didReturnEpisodes) {
        yield ApiResult.error(e);
      }
    }
  }

  Future<ApiResult<Iterable<Podcast>>> getMany(
    Iterable<String> podcastIds,
  ) async {
    _log.info('getMany');
    var podcasts = podcastIds.map((id) => Podcast(id: id)).toList();
    try {
      // I think the order may change here..
      await _database.getMany(podcasts);
      return ApiResult.ok(podcasts);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  Stream<ApiResult<Podcast>> get(String podcastId, {onlyLocal = false}) async* {
    _log.info('get::$podcastId');
    var request = GetPodcastApiRequest();
    var response = GetPodcastApiResponse();
    var podcast = Podcast(id: podcastId);
    request.requestPb.podcastId = podcastId;
    var didReturnPodcast = false;
    try {
      await _database.get(podcast);
      // await _episodeDatabase.populatePodcastEpisodes(podcast);

      yield ApiResult.ok(podcast);
      didReturnPodcast = true;
      if (onlyLocal) return;
    } on Exception catch (e) {
      // Do I return this?
      if (onlyLocal) {
        yield ApiResult.error(e);
        return;
      }
    }
    // TODO(duncan): Check if the database is stale and only request then.
    try {
      await _server.execute(request, response);
      podcast.fromMessage(response.responsePb.podcast);

      await _database.put(podcast);

      yield ApiResult.ok(podcast);
    } on Exception catch (e) {
      if (!didReturnPodcast) {
        yield ApiResult.error(e);
      }
    }
  }
}
