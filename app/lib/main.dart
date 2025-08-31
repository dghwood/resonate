import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/router/routes.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/services/http.dart';
import 'package:resonate/services/player.dart';
import 'package:resonate/services/secure_database.dart';

// import 'ui/scaffold.dart';
// import 'models/player.dart';
// import 'providers/backend.dart';

void main() async {
  // https://pub.dev/packages/just_audio_background
  // Requires more setup in .xml
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
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
      providers: [
        Provider<ErrorService>(create: (context) => ErrorService()),

        Provider<AbstractHttpService>(create: (context) => mockHttpService),
        Provider<AbstractSecureDatabase>(create: (context) => SecureDatabase()),
        Provider<SecureProtoDatabase>(
          create:
              (context) => SecureProtoDatabase(secureDatabase: context.read()),
        ),
        Provider<AbstractDatabaseService>(
          create:
              (context) => DatabaseService(
                idbFactoryNative,
                // idbFactoryNative,
                // authUser: context.read(),
                // user: context.read(),
              ),
        ),
        ChangeNotifierProvider<AuthUser>(
          create:
              (context) => AuthUser(
                secureDatabase: context.read(),
                httpService: context.read(),
                databaseService: context.read(),
              ),
        ),
        ChangeNotifierProvider<PlayerApi>(
          create:
              (context) => PlayerApi(
                authUser: context.read(),
                playerService: PlayerServiceMock(),
              ),
        ),
        // API
        Provider<SearchApi>(
          create:
              (context) =>
                  SearchApi(authUser: context.read(), client: context.read()),
        ),
        Provider<PodcastApi>(
          // Needed this so that the DB is setup
          lazy: false,
          create: (context) {
            return PodcastApi(
              authUser: context.read(),
              httpService: context.read(),
              databaseService: context.read(),
            );
          },
        ),
        Provider<GetEpisodeApi>(
          // Needed this so that the DB is setup
          lazy: false,
          create: (context) {
            return GetEpisodeApi(
              authUser: context.read(),
              httpService: context.read(),
              databaseService: context.read(),
            );
          },
        ),
        Provider<SubscriptionsApi>(
          create:
              (context) => SubscriptionsApi(
                authUser: context.read(),
                podcastApi: context.read(),
              ),
        ),
        Provider<ListensApi>(
          create:
              (context) => ListensApi(
                authUser: context.read(),
                episodeApi: context.read(),
              ),
        ),
      ],
      child: Builder(
        builder: (context) {
          AuthUser authUser = context.read<AuthUser>();
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              // brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: Colors.blue,
              ),
            ),
            routerConfig: appRouter(authUser),
          );
        },
      ),
    );
  }
}
