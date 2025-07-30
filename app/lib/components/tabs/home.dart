import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/tabs/base.dart';
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('HomePage');

class HomePage extends TabComponent {
  const HomePage({super.key}) : super(title: 'Home');

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      children: [
        Text('home'),
        TextButton(
          onPressed: () {
            var controller = showBottomSheet(
              enableDrag: false,
              constraints: BoxConstraints(maxHeight: 80),
              // backgroundColor: Colors.white,
              context: context,
              builder: (_) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: Center(
                    child: Column(children: [Expanded(child: Text('Hello'))]),
                  ),
                );
              },
            );

            _log.info(controller);
          },
          child: Text('Show Bottom Sheet'),
        ),
        TextButton(
          child: Text('loading'),
          onPressed: () {
            // Navigate(context).toLoading();
          },
        ),
      ],
    );
  }
}
