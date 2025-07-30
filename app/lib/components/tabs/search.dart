import 'package:flutter/material.dart';
// import 'package:resonate/components/pages/base.dart';
import 'package:resonate/router/navigation.dart';

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
      setState(() {});
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
    // return Text('Query: ${widget.query.value}');
    return ListView.builder(
      itemCount: widget.query.value == '' ? 0 : 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${widget.query.value} number $index'),
          onTap: () {
            Navigate(context).toPodcast('$index');
          },
        );
      },
    );
  }
}
