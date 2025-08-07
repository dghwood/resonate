import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/models/models.dart';
import 'package:resonate/router/routes.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/services/http.dart';
import 'firebase_options.dart';

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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Ideal time to initialize
  // firebase emualators:start
  await auth.FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

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
    var user = User();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (context) => user),
        Provider<AbstractDatabaseService>(
          create:
              (context) => DatabaseService(idbFactoryMemory, context.read()),
        ),
        Provider<AbstractHttpService>(create: (context) => mockHttpService),
        Provider<UserApi>(
          create:
              (context) => UserApi(
                httpService: context.read(),
                user: context.read(),
                databaseService: context.read(),
              ),
        ),
        Provider<GetPodcastApi>(
          create:
              (context) => GetPodcastApi(
                user: context.read(),
                httpService: context.read(),
                databaseService: context.read(),
              ),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          // brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: Colors.blue,
          ),
        ),
        routerConfig: appRouter(user),
      ),
    );
  }
}
