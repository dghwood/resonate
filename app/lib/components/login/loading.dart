import 'package:flutter/material.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/router/navigation.dart';

class LoadingAppComponent extends StatefulWidget {
  const LoadingAppComponent({super.key});

  @override
  State<LoadingAppComponent> createState() => _LoadingAppComponentState();
}

class _LoadingAppComponentState extends State<LoadingAppComponent> {
  @override
  void initState() {
    super.initState();
    initFuture = init();
  }

  late final Future<ApiResult<bool>> initFuture;

  Future<ApiResult<bool>> init() async {
    await Future.delayed(Duration(seconds: 5));
    return ApiResult.ok(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture,
      builder: (context, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navigation to the loading screen to init the app
          Navigate(context).toHome();
        });
        return Text('init');
      },
    );
  }
}
