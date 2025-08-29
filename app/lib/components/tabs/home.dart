import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/router/navigation.dart';
import 'package:resonate/api/errors.dart';

final Logger _log = Logger('HomePage');

class HomePage extends TabComponent {
  const HomePage({super.key}) : super(title: 'Home');

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      children: [
        Text('home'),

        TextButton(
          child: Text('show error'),
          onPressed: () {
            var errorService = context.read<ErrorService>();
            errorService.report(context, Exception('This is an error'));
          },
        ),
        TextButton(
          child: Text('Go to podcast'),
          onPressed: () {
            Navigate(context).toPodcast('123');
          },
        ),
      ],
    );
  }
}
