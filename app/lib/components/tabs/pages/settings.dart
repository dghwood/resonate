import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/components/tabs/pages/base.dart';
import 'package:resonate/router/navigation.dart';
import 'package:resonate/services/logger.dart';
import 'package:resonate/utils/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var settings = context.read<SettingsApi>().settings;
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Logging'),
            onTap: () => Navigate(context).toLoggingPage(),
          ),
          // ListTile(title: Text('Base URL'), subtitle: Text(BASE_URL)),
          ListTile(
            title: Text('Client Version'),
            subtitle: Text(CLIENT_VERSION),
          ),
        ],
      ),
    );
  }
}
