import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/components/common/addPhoto.dart';
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
class ProfilePage extends TabComponent {
  const ProfilePage({super.key}) : super(title: 'profile');

  @override
  Widget buildChild(BuildContext context) {
    return ProfileComponent();
  }
}

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            actions: [
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
          Row(
            children: [
              SizedBox(
                height: 200,
                child: Column(children: [ProfilePhotoComponent()]),
              ),
            ],
          ),
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Listens'),
                    Tab(text: 'Subscriptions'),
                    Tab(text: 'Stars'),
                    Tab(text: 'Downloads'),
                  ],
                ),
                SizedBox(
                  height:
                      400, // Set a fixed height for TabBarView to enable scrolling
                  child: TabBarView(
                    children: [
                      Center(child: Text('Listens')),
                      Center(child: Text('Subscriptions')),
                      Center(child: Text('Starts')),
                      Center(child: Text('Downloads')),
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
