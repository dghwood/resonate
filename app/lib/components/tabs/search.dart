import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/components/common/find_users.dart';
import 'package:resonate/components/common/infinite_scroll2.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/podcast.dart';
import 'package:resonate/components/common/subscribe.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('components/tabs/search');

enum SearchEditingControllerState { init, autocomplete, search }

class SearchEditingController extends ChangeNotifier {
  SearchEditingController({String? value}) : _value = value {
    controller = TextEditingController();
    controller.addListener(onListen);
  }

  void onListen() {
    _state = SearchEditingControllerState.autocomplete;
    _value = controller.text;
    if (controller.text.isEmpty) {
      _state = SearchEditingControllerState.init;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    controller.removeListener(onListen);
    super.dispose();
  }

  late final TextEditingController controller;
  SearchEditingControllerState _state = SearchEditingControllerState.init;
  SearchEditingControllerState get state => _state;
  String? _value;
  String? get value => _value;

  void clear() => controller.clear();

  void onSubmit(_) {
    _state = SearchEditingControllerState.search;
    notifyListeners();
  }
}

class SearchPageComponent extends StatelessWidget {
  const SearchPageComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var textEditingController = SearchEditingController();
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: textEditingController.controller,
          leading: Icon(Icons.search),
          trailing: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: textEditingController.clear,
            ),
          ],
          hintText: 'Search podcasts & users..',
          autoFocus: true,
          // onChanged: textEditingController.onChange,
          onSubmitted: textEditingController.onSubmit,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [Tab(text: 'Podcasts'), Tab(text: 'Users')]),
            Expanded(
              child: TabBarView(
                children: [
                  PodcastSearchPageComponent(
                    controller: textEditingController,
                    searchApi: context.read(),
                  ),
                  UserSearchPageComponent(controller: textEditingController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodcastSearchPageComponent extends StatelessWidget {
  const PodcastSearchPageComponent({
    super.key,
    required this.controller,
    required this.searchApi,
  });

  final SearchEditingController controller;
  final SearchApi searchApi;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.value == null) {
          // This doesn't happen
          return Text('No search term');
        }
        Future<ApiResult<SearchResults>> future;
        switch (controller.state) {
          case SearchEditingControllerState.init:
            future = searchApi.top();
          case SearchEditingControllerState.autocomplete:
            future = searchApi.autocomplete(controller.value!);
          case SearchEditingControllerState.search:
            future = searchApi.search(controller.value!);
        }
        return FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, _) {
                  return PodcastTile.loading();
                },
              );
            }
            var result = snapshot.requireData;
            switch (result) {
              case ApiOk():
                var searchResults = result.value;
                return ListView.builder(
                  itemCount: searchResults.results.length + 1,
                  itemBuilder: (context, index) {
                    if (index == searchResults.results.length) {
                      if (controller.state ==
                          SearchEditingControllerState.autocomplete) {
                        return TextButton(
                          child: Text('load more'),
                          onPressed: () {
                            controller.onSubmit(null);
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                    var podcast = searchResults.results[index].podcast!;
                    return PodcastTile(podcast: podcast);
                  },
                );
              case ApiError():
                return Text('Error: ${result.error}');
            }
          },
        );
      },
    );
  }
}

class UserSearchPageComponent extends StatelessWidget {
  const UserSearchPageComponent({
    super.key,
    required this.controller,
    required this.findUsersApi,
  });

  final SearchEditingController controller;
  final FindUsersApi findUsersApi;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.value == null) {
          // This doesn't happen
          return Text('No search term');
        }
        Future<ApiResult<SearchResults>> future;
        switch (controller.state) {
          case SearchEditingControllerState.init:
            return Text('share your contacts');
          case SearchEditingControllerState.autocomplete:
            return Text('share your contacts');
          case SearchEditingControllerState.search:
            future = findUsersApi.find(phoneNumbers)
        }

        return Text('user ${controller.value}');
      },
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
