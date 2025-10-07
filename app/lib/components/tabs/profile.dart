import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/components/common/add_photo.dart';
import 'package:resonate/components/common/downloads.dart';
import 'package:resonate/components/common/listens.dart';
import 'package:resonate/components/common/subscriptions.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

/* Needs 

  * Listen History 
  * Stars 
  * Downloads 
  * Settings 

  * Followers 
  * Following 

*/
// class ProfilePage extends TabComponent {
//   const ProfilePage({super.key}) : super(title: 'profile');

//   @override
//   Widget buildChild(BuildContext context) {
//     return ProfileComponent();
//   }
// }

class ProfileComponentHeader extends StatelessWidget {
  const ProfileComponentHeader({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200, child: Row(children: [Text(user.name)]));
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
            length: 4,
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
