import 'package:flutter/material.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/navigation.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final PublicUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageComponent(user.imageUrl),
        ),
        title: Text(user.name),
        onTap: () {
          Navigate(context).toPublicProfile(user.id);
        },
      ),
    );
  }
}
