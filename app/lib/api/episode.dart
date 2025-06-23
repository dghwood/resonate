import 'dart:typed_data';

import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';

class GetEpisodeApiRequest extends ApiRequest<GetEpisodeMessage_Request> {
  GetEpisodeApiRequest() : super(GetEpisodeMessage_Request());

  @override
  RequestInfo get requestInfo => requestPb.requestInfo;
}

class GetEpisodeApiResponse extends ApiResponse<GetEpisodeMessage_Response> {
  GetEpisodeApiResponse() : super(GetEpisodeMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;

  void fromEpisodeBuffer(Uint8List buffer) {
    responsePb.mergeFromBuffer(buffer);
  }
}

class GetEpisodeApiServer
    extends ServerApi<GetEpisodeApiRequest, GetEpisodeApiResponse> {
  GetEpisodeApiServer({AbstractHttpService? client})
    : super(
        GetEpisodeApiRequest(),
        GetEpisodeApiResponse(),
        'api/episode/get',
        client: client,
      );
}

class GetEpisodeApi {
  GetEpisodeApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
  }) : _server = GetEpisodeApiServer(client: httpService),
       _database = EpisodeDatabase(databaseService);

  final GetEpisodeApiServer _server;
  final EpisodeDatabase _database;

  Stream<ApiResult<Episode>> get(String episodeId) async* {
    var request = GetEpisodeApiRequest();
    request.requestPb.episodeId = episodeId;

    var response = GetEpisodeApiResponse();
    var episode = Episode(id: episodeId);
    try {
      await _database.get(episode);
      yield ApiResult.ok(episode);
    } on Exception catch (_) {
      // Do I return this?
      // yield ApiResult.error(e);
    }
    // TODO(duncan): Check if the database is stale and only request then.
    try {
      await _server.execute(request, response);
      Episode.fromMessage(response.responsePb.episode);

      await _database.put(episode);

      yield ApiResult.ok(episode);
    } on Exception catch (e) {
      yield ApiResult.error(e);
    }
  }
}
