import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/feed.dart';
import 'package:resonate/api/follow.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/api/upload.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/mock_http.dart';
import 'package:resonate/services/contacts.dart';
import 'package:resonate/services/http/cookie_jar.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/services/player.dart';
import 'package:resonate/services/secure_database/secure_database.dart';

final _baseProviders = [
  Provider<ErrorService>(create: (context) => ErrorService()),
  Provider<AbstractSecureDatabase>(create: (context) => SecureDatabase()),
  // Provider<AbstractHttpService>(create: (context) => mockHttpService),
  Provider<AbstractHttpService>(
    create: (context) => HttpService(secureDatabse: context.read()),
  ),
  Provider<SecureProtoDatabase>(
    create: (context) => SecureProtoDatabase(secureDatabase: context.read()),
  ),
  Provider<AbstractDatabaseService>(
    create:
        (context) =>
            DatabaseService(kIsWeb ? idbFactoryNative : idbFactorySqflite),
  ),
  ChangeNotifierProvider<AuthUser>(
    create:
        (context) => AuthUser(
          secureDatabase: context.read(),
          httpService: context.read(),
          databaseService: context.read(),
        ),
  ),
];
final providers =
    _baseProviders +
    [
      Provider<SettingsApi>(
        create:
            (context) => SettingsApi(
              // httpService: context.read(),
              // authUser: context.read(),
              databaseService: context.read(),
            ),
      ),
      Provider<PlaylistApi>(create: (context) => PlaylistApi()),
      ChangeNotifierProvider<PlayerApi>(
        create:
            (context) => PlayerApi(
              playlistApi: context.read(),
              authUser: context.read(),
              playerService: PlayerService(),
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
              httpService: context.read(),
              authUser: context.read(),
              podcastApi: context.read(),
            ),
      ),
      Provider<ListensApi>(
        create:
            (context) => ListensApi(
              httpService: context.read(),
              authUser: context.read(),
              episodeApi: context.read(),
            ),
      ),
      // Provider<GetFeedApi>(
      //   // Needed this so that the DB is setup
      //   lazy: false,
      //   create:
      //       (context) => GetFeedApi(
      //         httpService: context.read(),
      //         databaseService: context.read(),
      //         authUser: context.read(),
      //       ),
      // ),
      Provider<DownloadsApi>(
        create:
            (context) => DownloadsApi(
              episodeApi: context.read(),
              authUser: context.read(),
            ),
      ),
      Provider<UploadApi>(
        create:
            (context) =>
                UploadApi(authUser: context.read(), client: context.read()),
      ),
      Provider<SearchContactsApi>(
        create:
            (context) => SearchContactsApi(
              authUser: context.read(),
              client: context.read(),
              contactsSerivce: MockContacts(),
            ),
      ),
      Provider<PublicUserApi>(
        create:
            (context) => PublicUserApi(
              authUser: context.read(),
              httpService: context.read(),
            ),
      ),
      Provider<FollowApi>(
        lazy: false,
        create:
            (context) => FollowApi(
              authUser: context.read(),
              client: context.read(),
              databaseService: context.read(),
            ),
      ),
    ];
