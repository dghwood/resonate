import 'package:flutter/material.dart';
import 'package:resonate/components/tabs/pages/base.dart';

class SettingsPage extends PageComponent {
  const SettingsPage({super.key}) : super(title: 'Settings');

  @override
  Widget buildChild(BuildContext context) {
    return Text('settings');
  }
}
