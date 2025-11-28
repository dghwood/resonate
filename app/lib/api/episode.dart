import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/storage/episode.dart';

Logger _log = Logger('api/episode');

class GetEpisodeApiRequest extends ApiRequest<GetEpisodeMessage_Request> {
  GetEpisodeApiRequest()
    : super(GetEpisodeMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) =>
      requestPb.requestInfo.mergeFromMessage(info);
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
  GetEpisodeApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         GetEpisodeApiRequest(),
         GetEpisodeApiResponse(),
         'api/episode/get',
         client: client,
         authUser: authUser,
       );
}

class GetEpisodeApi {
  GetEpisodeApi({
    required AbstractHttpService httpService,
    required AbstractDatabaseService databaseService,
    required AuthUser authUser,
  }) : _server = GetEpisodeApiServer(client: httpService, authUser: authUser),
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

  Future<ApiResult<Iterable<Episode>>> getMany(
    Iterable<String> episodeIds,
  ) async {
    var episodes = episodeIds.map((id) => Episode(id: id)).toList();
    _log.info('getMany::$episodes');
    try {
      // I think the order may change here..
      await _database.getMany(episodes);
      _log.info('database returned');
      return ApiResult.ok(episodes);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}
