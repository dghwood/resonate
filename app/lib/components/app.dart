import 'package:flutter/material.dart';

class ResonateScaffold extends StatelessWidget {
  const ResonateScaffold({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Simple Scaffold')),
        body: child,
      ),
    );
  }
}
