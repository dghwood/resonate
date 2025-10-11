import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/components/common/find_users.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('components/tabs/search');

/* SearchComponent 


  SearchComponent 
   * SearchResultsComponent 
    * InfiniteScrollComponent
*/
class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [Tab(text: 'Podcasts'), Tab(text: 'Users')]),
            Expanded(
              child: TabBarView(
                children: [PodcastSearchComponent(), UsersSearchComponent()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodcastSearchComponent extends StatefulWidget {
  const PodcastSearchComponent({super.key});

  @override
  State<PodcastSearchComponent> createState() => _PodcastSearchComponentState();
}

class _PodcastSearchComponentState extends State<PodcastSearchComponent> {
  final ValueNotifier<String> query = ValueNotifier<String>('');
  final ValueNotifier<String> typeAheadQuery = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    var searchApi = context.read<SearchApi>();
    return Column(
      children: [
        SearchBar(
          leading: Icon(Icons.search),
          hintText: 'Search',
          autoFocus: true,
          onChanged: (value) {
            typeAheadQuery.value = value;
          },
          onSubmitted: (value) {
            setState(() => query.value = value);
          },
        ),
        Expanded(
          child: Stack(
            children: [
              SearchResultsComponent(query: query, searchApi: searchApi),
              Positioned(
                child: TypeAheadSearchResultsComponent(
                  query: typeAheadQuery,
                  searchApi: searchApi,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TypeAheadSearchResultsComponent extends StatelessWidget {
  const TypeAheadSearchResultsComponent({
    super.key,
    required this.query,
    required this.searchApi,
  });

  final ValueNotifier<String> query;
  final SearchApi searchApi;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchApi.getTypeaheadApi(), // This is cached
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        var result = snapshot.requireData;
        switch (result) {
          case ApiOk():
            break;
          case ApiError():
            context.read<ErrorService>().report(context, result.error);
            return SizedBox();
        }

        var typeaheadApi = result.value;
        return ListenableBuilder(
          listenable: query,
          builder: (context, _) {
            if (query.value == '') return SizedBox();
            var results = typeaheadApi.search(query.value);
            return ListView.builder(
              itemCount: results.length + 1,
              itemBuilder: (context, index) {
                if (index == results.length) {
                  return Text('press enter to find more...');
                }
                var podcast = results.elementAt(index);
                return Container(
                  color: Theme.of(context).canvasColor,
                  child: ListTile(
                    title: Text(podcast.title),
                    leading: ImageComponent(podcast.imageUrl),
                    onTap: () {
                      Navigate(context).toPodcast(podcast.id);
                    },
                  ),
                );
              },
            );
          },
        );
      },
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
    widget.query.addListener(_onQueryChange);
  }

  void _onQueryChange() {
    setState(() {
      _log.info('query: ${widget.query.value}');
    });
  }

  @override
  void dispose() {
    widget.query.removeListener(_onQueryChange);
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
      leading: ImageComponent(podcast.imageUrl),
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
      builder: _itemBuilder,
    );
  }
}

class UsersSearchComponent extends StatelessWidget {
  const UsersSearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return FindUsersComponent(findUsersApi: context.read());
  }
}
