import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/components/common/find_users.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
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
                  UserSearchPageComponent(
                    controller: textEditingController,
                    searchContactsApi: context.read(),
                  ),
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

/* UserSearchPageComponent 

  I'm trying to think this through. 
  * You need to ask for permission to the contacts. 
    * Can you search without that permission 
      * Yes? 
    * You need to be able to give permission 
      * Then how does search behave differently 
    
  In the search api above we have two things 
    * Search 
      * This searches all the users 
    * Top 
      * This provides your contacts (if you have permission) 
      * If no permission then just all users (?) 
        * need to think about ranking here. 

*/
class UserSearchPageComponent extends StatelessWidget {
  const UserSearchPageComponent({
    super.key,
    required this.controller,
    required this.searchContactsApi,
  });

  final SearchEditingController controller;
  final SearchContactsApi searchContactsApi;

  @override
  Widget build(BuildContext context) {
    var topFuture = searchContactsApi.top();
    var scrollController = ScrollController();
    _log.info(
      'hasContactsPermission ${searchContactsApi.hasContactsPermission}',
    );
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.value == null) {
          // This doesn't happen
          return Text('No search term');
        }
        Future<IterableApiResult<Iterable<PublicUser>>> future;
        switch (controller.state) {
          case SearchEditingControllerState.init:
            future = topFuture;
          case SearchEditingControllerState.autocomplete:
            future = topFuture;
          case SearchEditingControllerState.search:
            future = searchContactsApi.search(controller.value!);
        }

        return Column(
          children: [
            if (!searchContactsApi.hasContactsPermission)
              ListTile(
                title: Text('Share your contacts, find your friends'),
                leading: Icon(Icons.person),
                onTap: () async {
                  await searchContactsApi.requestPermission();
                  // This will refresh the whole widget.
                  controller.onSubmit(null);
                },
              ),
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingSpinnerComponent();
                  }
                  var result = snapshot.requireData;
                  switch (result) {
                    case ApiOkIterable():
                      break;
                    case ApiErrorIterable():
                      return Text('Error: ${result.error}');
                  }
                  return InfiniteScrollComponent(
                    iterableApiResult: result,
                    scrollController: scrollController,
                    itemBuilder: (BuildContext context, item) {
                      return ListTile(
                        leading: ImageComponent(item.imageUrl),
                        title: Text(item.name),
                        onTap: () {
                          Navigate(context).toPublicProfile(item.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
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
