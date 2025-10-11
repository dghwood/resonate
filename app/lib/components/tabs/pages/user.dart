import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';

class PublicUserProfileComponent extends StatelessWidget {
  const PublicUserProfileComponent({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    // return NestedScrollView(
    //   controller: controller,
    //   headerSliverBuilder: SliverAppBar(
    //       leading: ImageComponent(user.imageUrl),
    //       title: Text(user.name),
    //     ),
    //   body: body)
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1), () {
        return PublicUser(imageUrl: "/images/users/stock", name: "Test user");
      }),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinnerComponent();
        }
        var user = asyncSnapshot.requireData;

        return DefaultTabController(
          length: 2,
          child: NestedScrollView(
            controller: controller,
            headerSliverBuilder: (context, someBool) {
              print(someBool);
              return [
                SliverAppBar(
                  leading: ImageComponent(user.imageUrl),
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(),
                  expandedHeight: 200.0,
                  title: Text(user.name),
                  bottom: TabBar(
                    tabs: [Tab(text: 'Listens'), Tab(text: 'Subscriptions')],
                  ),
                ),
              ];
            },
            body: TabBarView(
              // The content for each tab
              children: <Widget>[
                PublicUserListensComponent(
                  user: user,
                  scrollController: controller,
                ),
                PublicUserSubscriptionsComponent(user: user),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PublicUserListensComponent extends StatelessWidget {
  const PublicUserListensComponent({
    super.key,
    required this.user,
    required this.scrollController,
  });

  final PublicUser user;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    var listensApi = context.read<ListensApi>();
    var future = listensApi.listForUser(user.id);
    return FutureBuilder(
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

        if (result.result.isEmpty) return Text('No listens');

        return InfiniteScrollComponent(
          // Needed to put this here, since
          // the stream would cache this component
          key: Key(result.hashCode.toString()),
          iterableApiResult: result,
          scrollController: scrollController,
          itemBuilder: (context, item) {
            return Text("listen");
          },
        );
      },
    );
  }
}

class PublicUserSubscriptionsComponent extends StatelessWidget {
  const PublicUserSubscriptionsComponent({super.key, required this.user});

  final PublicUser user;
  @override
  Widget build(BuildContext context) {
    return Text('Subscriptions');
  }
}
