import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/proto/api.pb.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/utils/search.dart';

final Logger _log = Logger('api/search');

class SearchApiRequest extends ApiRequest<SearchMessage_Request> {
  SearchApiRequest() : super(SearchMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class SearchApiResponse extends ApiResponse<SearchMessage_Response> {
  SearchApiResponse() : super(SearchMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class SearchApiServer extends ServerApi<SearchApiRequest, SearchApiResponse> {
  SearchApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SearchApiRequest(),
         SearchApiResponse(),
         'api/search/query',
         authUser: authUser,
         client: client,
       );
}

class SearchTopApiRequest extends ApiRequest<SearchTopMessage_Request> {
  SearchTopApiRequest()
    : super(SearchTopMessage_Request(requestInfo: RequestInfo()));

  @override
  set requestInfo(RequestInfo info) {
    requestPb.requestInfo.mergeFromMessage(info);
  }
}

class SearchTopApiResponse extends ApiResponse<SearchTopMessage_Response> {
  SearchTopApiResponse() : super(SearchTopMessage_Response());

  @override
  ResponseInfo get responseInfo => responsePb.responseInfo;
}

class SearchTopApiServer
    extends ServerApi<SearchTopApiRequest, SearchTopApiResponse> {
  SearchTopApiServer({
    required AbstractHttpService client,
    required AuthUser authUser,
  }) : super(
         SearchTopApiRequest(),
         SearchTopApiResponse(),
         'api/search/top',
         authUser: authUser,
         client: client,
       );
}

class TypeaheadApi {
  TypeaheadApi(SearchResults searchResults) : _searchResults = searchResults;

  final SearchResults _searchResults;

  Iterable<Podcast> search(String query) {
    if (query.isEmpty) return [];
    var results = <Podcast>[];
    for (var result in _searchResults.results) {
      // Just for podcasts
      if (result.podcast == null) continue;
      var podcast = result.podcast!;
      // Very basic search
      if (podcast.title.toLowerCase().contains(query.toLowerCase())) {
        results.add(podcast);
      }
    }
    return results;
  }
}

class SearchApi {
  SearchApi({required AbstractHttpService client, required AuthUser authUser})
    : _server = SearchApiServer(authUser: authUser, client: client),
      _topServer = SearchTopApiServer(authUser: authUser, client: client);

  final SearchApiServer _server;
  final SearchTopApiServer _topServer;

  // Very lazy in memory cache for now
  TypeaheadApi? _typeaheadApi;

  Future<ApiResult<TypeaheadApi>> getTypeaheadApi() async {
    if (_typeaheadApi != null) return ApiResult.ok(_typeaheadApi!);
    var result = await top();
    switch (result) {
      case ApiOk():
        _typeaheadApi = TypeaheadApi(result.value);
        return ApiResult.ok(_typeaheadApi!);
      case ApiError():
        return ApiResult.error(result.error);
    }
  }

  // Returns the top N podcasts of the day
  // Heavily cache this..
  Future<ApiResult<SearchResults>> top() async {
    if (_autocompleteResults != null) {
      return ApiResult.ok(_autocompleteResults!);
    }
    var request = SearchTopApiRequest();
    var response = SearchTopApiResponse();
    try {
      await _topServer.execute(request, response);
      _autocompleteResults = SearchResults.fromMessage(
        response.responsePb.searchResults,
      );
      return ApiResult.ok(_autocompleteResults!);
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }

  SearchResults? _autocompleteResults;
  Future<ApiResult<SearchResults>> autocomplete(String query) async {
    if (query.isEmpty) return ApiResult.ok(SearchResults());
    if (_autocompleteResults == null) {
      var result = await top();
      if (result is! ApiOk) return result;
    }

    // Implement simple search
    return ApiResult.ok(
      SearchResults.copyWithFilter(_autocompleteResults!, (result) {
        if (result.podcast == null) return false;
        var podcast = result.podcast!;
        return SearchablePodcastModel(podcast).search(query);
      }),
    );
  }

  // I feel like this needs to return various types..
  Future<ApiResult<SearchResults>> search(
    String query, {
    String mode = 'PODCASTS',
  }) async {
    var request = SearchApiRequest();
    request.requestPb.query = query;
    // Update the request type.. eg. Podcasts
    var response = SearchApiResponse();

    try {
      await _server.execute(request, response);
      return ApiResult.ok(
        SearchResults.fromMessage(response.responsePb.searchResults),
      );
    } on Exception catch (e) {
      return ApiResult.error(e);
    }
  }
}
