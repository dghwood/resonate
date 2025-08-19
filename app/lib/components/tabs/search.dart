import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('components/tabs/search');

/* SearchComponent 


  SearchComponent 
   * SearchResultsComponent 
    * InfiniteScrollComponent
*/
class SearchComponent extends StatefulWidget {
  const SearchComponent({super.key});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  final ValueNotifier<String> query = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    var searchApi = context.read<SearchApi>();
    return Material(
      child: Column(
        children: [
          SearchBar(
            leading: Icon(Icons.search),
            hintText: 'Search',
            autoFocus: true,
            onSubmitted: (value) {
              setState(() => query.value = value);
            },
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Podcasts'),
                      Tab(text: 'Episodes'),
                      Tab(text: 'Users'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SearchResultsComponent(
                          query: query,
                          searchApi: searchApi,
                        ),
                        Text('Episodes'),
                        Text('Users'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ),
          //SearchResultsComponent(query: query),
        ],
      ),
    );
  }
}

class SearchResultsComponent extends StatefulWidget {
  const SearchResultsComponent({
    super.key,
    required this.query,
    required this.searchApi,
  });

  final ValueNotifier<String> query;
  final SearchApi searchApi;

  @override
  State<SearchResultsComponent> createState() => _SearchResultsComponentState();
}

class _SearchResultsComponentState extends State<SearchResultsComponent> {
  @override
  void initState() {
    super.initState();
    widget.query.addListener(() {
      setState(() {
        _log.info('query: ${widget.query.value}');
      });
    });
  }

  @override
  void dispose() {
    widget.query.removeListener(() {
      setState(() {});
    });
    _log.info('results::dispose');
    super.dispose();
  }

  Future<ApiResult<Iterable<SearchResult>>> _next(int currentPage) async {
    _log.info('_next');
    var result = await widget.searchApi.search(widget.query.value);
    // Need to find a way to say i'm done..
    switch (result) {
      case ApiOk():
        _log.info('_next::${result.value.results.length}');
        return ApiResult.ok(result.value.results);
      case ApiError():
        return ApiResult.error(result.error);
    }
  }

  Widget _itemBuilder(
    BuildContext context,
    int index,
    List<SearchResult> results,
  ) {
    var podcast = results[index].podcast!;
    return ListTile(
      leading: Image.network(podcast.imageUrl),
      title: Text(podcast.title),
      subtitle: Text(
        podcast.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigate(context).toPodcast(podcast.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.value == '') return Text('No search term');
    return InfiniteScrollComponent<SearchResult>(
      key: Key(widget.query.value),
      next: _next,
      itemBuilder: _itemBuilder,
    );
  }
}
