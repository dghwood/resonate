import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/search.dart';

final Logger _log = Logger('components/tabs/search');

class SearchComponent extends StatelessWidget {
  SearchComponent({super.key});

  final ValueNotifier<String> query = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SearchBar(
            leading: Icon(Icons.search),
            hintText: 'Search',
            autoFocus: true,
            onSubmitted: (value) {
              query.value = value;
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
                        SearchResultsComponent(query: query),
                        SearchResultsComponent(query: query),
                        SearchResultsComponent(query: query),
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
  const SearchResultsComponent({super.key, required this.query});

  final ValueNotifier<String> query;

  @override
  State<SearchResultsComponent> createState() => _SearchResultsComponentState();
}

class _SearchResultsComponentState extends State<SearchResultsComponent> {
  @override
  void initState() {
    super.initState();
    widget.query.addListener(() {
      setState(() {
        _log.info('${widget.query.value}');
      });
    });
  }

  @override
  void dispose() {
    widget.query.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.value == '') return Text('waiting');
    _log.info('build');
    return FutureBuilder(
      future: context.read<SearchApi>().search(widget.query.value),
      builder: (context, snapshot) {
        _log.info('builder::${snapshot.connectionState}');

        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        }
        var result = snapshot.data!;
        switch (result) {
          case ApiOk():
            var searchResults = result.value;
            return ListView.builder(
              itemCount: searchResults.results.length,
              itemBuilder: (context, index) {
                var item = searchResults.results[index];
                // TODO(duncan): Handle other types
                var podcast = item.podcast!;
                return ListTile(
                  leading: Image.network(podcast.imageUrl),
                  title: Text(podcast.title),
                  subtitle: Text(
                    podcast.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            );
          case ApiError():
            return Text('error ${result.error}');
        }
      },
    );
  }
}
