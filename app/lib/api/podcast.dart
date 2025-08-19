import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/errors/errors.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/proto/common.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/podcast.dart';

Logger _log = Logger('PodcastApi');

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

  Stream<ApiResult<Iterable<Episode>>> list(String podcastId) async* {
    var request = ListPodcastEpisodesApiRequest();
    request.requestPb.podcastId = podcastId;
    var response = ListPodcastEpisodesApiResponse();

    try {
      var episodes = await _episodeDatabase.listFromPodcastId(podcastId);
      yield ApiResult.ok(episodes);
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
      yield ApiResult.error(e);
    }
  }

  Stream<ApiResult<Podcast>> get(String podcastId) async* {
    var request = GetPodcastApiRequest();
    var response = GetPodcastApiResponse();
    var podcast = Podcast(id: podcastId);
    try {
      await _database.get(podcast);
      // await _episodeDatabase.populatePodcastEpisodes(podcast);

      yield ApiResult.ok(podcast);
    } on Exception catch (_) {
      // Do I return this?
      // yield ApiResult.error(e);
    }
    // TODO(duncan): Check if the database is stale and only request then.
    try {
      await _server.execute(request, response);
      podcast.fromMessage(response.responsePb.podcast);

      await _database.put(podcast);
      // await _episodeDatabase.putAll(
      //   response.responsePb.podcast.episodes
      //       .map((e) => Episode.fromMessage(e))
      //       .toList(),
      // );

      yield ApiResult.ok(podcast);
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }
}
