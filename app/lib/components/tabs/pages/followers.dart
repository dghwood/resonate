import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/components/common/follow.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';

class FollowersPageComponent extends StatelessWidget {
  const FollowersPageComponent({super.key, required this.user});

  final PublicUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [ProfileImageComponent(user.imageUrl), Text(user.name)],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [Tab(text: 'Followers'), Tab(text: 'Following')]),
            Expanded(
              child: TabBarView(
                children: [
                  FollowListComponent(user: user, followApi: context.read()),
                  FollowListComponent(
                    user: user,
                    followApi: context.read(),

                    isFollowed: true,
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
