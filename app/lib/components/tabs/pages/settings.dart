import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/components/tabs/pages/base.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var settings = context.read<SettingsApi>().settings;
    return Scaffold(appBar: AppBar(title: Text('Settings')), body: Column());
  }
}
