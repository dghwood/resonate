import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/follow.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/follow.dart';
import 'package:resonate/components/common/infinite_scroll.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key, required this.user});

  final PublicUser user;

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();

    return Material(
      child: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, _) {
            return [
              SliverAppBar(
                actions: [],
                leading: ImageComponent(user.imageUrl),
                pinned: true,
                floating: true,
                title: Text(user.name),
                bottom: TabBar(
                  tabs: [Tab(text: 'Following'), Tab(text: 'Followers')],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FollowListComponent(
                user: user,
                followApi: context.read(),
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
