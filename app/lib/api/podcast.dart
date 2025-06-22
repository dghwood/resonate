import 'dart:typed_data';

import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';
import 'package:resonate/storage/podcast.dart';

class GetPodcastApiRequest extends ApiRequest<GetPodcastMessage_Request> {
  GetPodcastApiRequest() : super(GetPodcastMessage_Request());

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
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
  GetPodcastApiServer({AbstractHttpService? client})
    : super(
        GetPodcastApiRequest(),
        GetPodcastApiResponse(),
        'api/podcast/get',
        client: client,
      );
}

class GetPodcastApi {
  GetPodcastApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
  }) : _server = GetPodcastApiServer(client: httpService),
       _database = PodcastDatabase(databaseService),
       // TODO(duncanwood): The upgrade function will be called twice!
       _episodeDatabase = EpisodeDatabase(databaseService);

  final GetPodcastApiServer _server;
  final PodcastDatabase _database;
  final EpisodeDatabase _episodeDatabase;

  Stream<ApiResult<Podcast>> get(String podcastId) async* {
    var request = GetPodcastApiRequest();
    var response = GetPodcastApiResponse();
    var podcast = Podcast(id: podcastId);
    try {
      await _database.get(podcast);
      await _episodeDatabase.populatePodcastEpisodes(podcast);

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
      await _episodeDatabase.putAll(
        response.responsePb.podcast.episodes
            .map((e) => Episode.fromMessage(e))
            .toList(),
      );

      yield ApiResult.ok(podcast);
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }
}
