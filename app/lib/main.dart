import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio_background/just_audio_background.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/providers.dart';
import 'package:resonate/router/routes.dart';
import 'package:resonate/services/logger.dart';
import 'package:resonate/services/player/audio_handler.dart';
import 'package:resonate/test_page.dart';
import 'package:resonate/utils/time.dart';

void main() async {
  // https://pub.dev/packages/just_audio_background
  // Requires more setup in .xml

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.instance.init();

  // GoRouter and it's silly changes.
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Since this is a singleton, and I've build the
    // database service off assuming this runs before we init
    // I need to reference here to 'create' it..
    // But perhaps I should redesign the database service.
    var listenApi = ListenApi.instance;
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          AuthUser authUser = context.read<AuthUser>();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              // iconTheme: IconThemeData(
              //   weight: 700,
              //   color: Colors.lightBlueAccent,
              // ),
              // brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: Colors.lightBlueAccent,
                // seedColor: Color.fromARGB(255, 57, 113, 62),
                // seedColor: Colors.white,
              ),
            ),
            routerConfig: appRouter(authUser),
          );
        },
      ),
    );
  }
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            // brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: Colors.blue,
            ),
          ),
          home: Scaffold(body: TestingComponent()),
        );
      },
    );
  }
}
