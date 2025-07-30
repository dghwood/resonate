import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('TabComponent');

abstract class TabComponent extends StatelessWidget {
  const TabComponent({super.key, required this.title});

  final String title;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildChild(context);
  }
}
