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
import 'package:resonate/components/common/user.dart';
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

class PodcastSearchPageComponent extends StatefulWidget {
  const PodcastSearchPageComponent({
    super.key,
    required this.controller,
    required this.searchApi,
  });

  final SearchEditingController controller;
  final SearchApi searchApi;

  @override
  State<PodcastSearchPageComponent> createState() =>
      _PodcastSearchPageComponentState();
}

class _PodcastSearchPageComponentState
    extends State<PodcastSearchPageComponent> {
  late Future<ApiResult<SearchResults>> future;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        if (widget.controller.value == null) {
          // This doesn't happen
          return Text('No search term');
        }
        switch (widget.controller.state) {
          case SearchEditingControllerState.init:
            future = widget.searchApi.top();
          case SearchEditingControllerState.autocomplete:
            future = widget.searchApi.autocomplete(widget.controller.value!);
          case SearchEditingControllerState.search:
            future = widget.searchApi.search(widget.controller.value!);
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
                break;
              case ApiError():
                context.read<ErrorService>().report(context, result.error);
                return OutlinedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('retry search'),
                );
            }

            var searchResults = result.value;

            return ListView.builder(
              itemCount: searchResults.results.length + 1,
              itemBuilder: (context, index) {
                if (index == searchResults.results.length) {
                  if (widget.controller.state ==
                      SearchEditingControllerState.autocomplete) {
                    return TextButton(
                      child: Text('load more'),
                      onPressed: () {
                        widget.controller.onSubmit(null);
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
    var scrollController = ScrollController();
    _log.info(
      'hasContactsPermission ${searchContactsApi.hasContactsPermission}',
    );
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        Future<IterableApiResult<Iterable<PublicUser>>> future;
        var query = controller.value ?? '';

        switch (controller.state) {
          case SearchEditingControllerState.init:
            future = searchContactsApi.top();
          case SearchEditingControllerState.autocomplete:
            future = searchContactsApi.autocomplete(query);
          case SearchEditingControllerState.search:
            future = searchContactsApi.search(query);
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
                      context.read<ErrorService>().report(
                        context,
                        result.error,
                      );
                      return OutlinedButton(
                        onPressed: () {
                          controller.onSubmit(null);
                        },
                        child: Text('retry'),
                      );
                  }
                  _log.info('Found ${result.result.length} users');
                  return InfiniteScrollComponent(
                    iterableApiResult: result,
                    scrollController: scrollController,
                    itemBuilder: (BuildContext context, user) {
                      return UserTile(user: user);
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
