import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/components/common/add_photo.dart';
import 'package:resonate/components/common/models/downloads.dart';
import 'package:resonate/components/common/models/listens.dart';
import 'package:resonate/components/common/models/subscriptions.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('components/tabs/profile');

class ProfileComponentHeader extends StatelessWidget {
  const ProfileComponentHeader({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    _log.info(user);
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          ImageComponent(user.imageUrl),
          // ImageComponent(user.imageUrl, width: 150, height: 150),
          Text(user.name),
        ],
      ),
    );
  }
}

/* ProfileComponent 

  Should be generic for any user object, including 
  viewing other profiles. 
*/
class ProfileComponent extends StatelessWidget {
  const ProfileComponent({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            actions: [
              // TODO(duncan): Only show these on logged in profile
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigate(context).editProfile(),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigate(context).toSettings(),
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => context.read<AuthUser>().signout(),
              ),
            ],
          ),
          ProfileComponentHeader(user: user),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Listens'),
                    Tab(text: 'Subscriptions'),
                    // Tab(text: 'Stars'),
                    Tab(text: 'Downloads'),
                  ],
                ),
                SizedBox(
                  height:
                      400, // Set a fixed height for TabBarView to enable scrolling
                  child: TabBarView(
                    children: [
                      ListensListComponent(listensApi: context.read()),
                      SubscriptionListComponent(
                        subscriptionsApi: context.read(),
                      ),
                      // Center(child: Text('Starts')),
                      // TODO(duncan): Don't show this one for non logged in users.
                      DownloadsListComponent(downloadsApi: context.read()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
