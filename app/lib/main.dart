import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/providers.dart';
import 'package:resonate/router/routes.dart';
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

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName}: ${record.message}');
  });
  // GoRouter and it's silly changes.
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) {
          AuthUser authUser = context.read<AuthUser>();
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
      ),
    );
  }
}

class EpisodeComponent extends StatelessWidget {
  const EpisodeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var episode = Episode.fromMessage(mockEpisodeMessage());
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          // Header
          Row(
            spacing: 8,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageComponent(episode.imageUrl, height: 60),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    formatTimeAgo(episode.publishDateTime),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
          Text(episode.description),
          Divider(),
        ],
      ),
    );
  }
}
