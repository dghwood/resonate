import 'package:flutter/foundation.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/contacts.dart';
import 'package:resonate/api/download.dart';
import 'package:resonate/api/episode.dart';
import 'package:resonate/api/follow.dart';
import 'package:resonate/api/listens.dart';
import 'package:resonate/api/player.dart';
import 'package:resonate/api/playlist.dart';
import 'package:resonate/api/podcast.dart';
import 'package:resonate/api/search.dart';
import 'package:resonate/api/settings.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/api/upload.dart';
import 'package:resonate/api/user.dart';
import 'package:resonate/services/contacts.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/services/http/http.dart';
import 'package:resonate/services/player/player.dart';
import 'package:resonate/services/secure_database/secure_database.dart';
import 'package:resonate/services/secure_database/secure_proto_database.dart';

final _baseProviders = [
  Provider<ErrorService>(create: (context) => ErrorService()),
  Provider<AbstractSecureDatabase>(
    create: (context) => SecureDatabase.instance,
  ),
  // Provider<AbstractHttpService>(create: (context) => mockHttpService),
  Provider<AbstractHttpService>(create: (context) => HttpService.instance),
  Provider<SecureProtoDatabase>(
    create: (context) => SecureProtoDatabase.instance,
  ),
  Provider<AbstractDatabaseService>(
    create: (context) => DatabaseService.instance,
  ),
  ChangeNotifierProvider<AuthUser>(create: (context) => AuthUser.instance),
];
final providers =
    _baseProviders +
    [
      Provider<SettingsApi>(
        create:
            (context) => SettingsApi(
              // httpService: context.read(),
              // authUser: AuthUser.instance,
              databaseService: context.read(),
            ),
      ),

      // API
      Provider<SearchApi>(
        create:
            (context) =>
                SearchApi(authUser: AuthUser.instance, client: context.read()),
      ),
      Provider<PodcastApi>(
        // Needed this so that the DB is setup
        lazy: false,
        create: (context) {
          return PodcastApi(
            authUser: AuthUser.instance,
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
            authUser: AuthUser.instance,
            httpService: context.read(),
            databaseService: context.read(),
          );
        },
      ),

      Provider<PlaylistApi>(
        lazy: false,
        create:
            (context) => PlaylistApi(
              databaseService: context.read(),
              episodeApi: context.read(),
            ),
      ),
      ChangeNotifierProvider<PlayerApi>(
        create:
            (context) => PlayerApi(
              playlistApi: context.read(),
              authUser: AuthUser.instance,
              playerService: PlayerService(),
            ),
      ),
      ChangeNotifierProvider<SubscriptionsApi>(
        create:
            (context) => SubscriptionsApi(
              httpService: context.read(),
              authUser: AuthUser.instance,
              podcastApi: context.read(),
            ),
      ),
      Provider<ListensApi>(
        create:
            (context) => ListensApi(
              httpService: context.read(),
              authUser: AuthUser.instance,
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
      //         authUser: AuthUser.instance,
      //       ),
      // ),
      Provider<DownloadsApi>(
        create:
            (context) => DownloadsApi(
              episodeApi: context.read(),
              authUser: AuthUser.instance,
            ),
      ),
      Provider<UploadApi>(
        create:
            (context) =>
                UploadApi(authUser: AuthUser.instance, client: context.read()),
      ),
      Provider<SearchContactsApi>(
        create:
            (context) => SearchContactsApi(
              authUser: AuthUser.instance,
              client: context.read(),
              contactsSerivce: MockContacts(),
            ),
      ),
      Provider<PublicUserApi>(
        create:
            (context) => PublicUserApi(
              authUser: AuthUser.instance,
              httpService: context.read(),
            ),
      ),
      Provider<FollowApi>(
        lazy: false,
        create:
            (context) => FollowApi(
              authUser: AuthUser.instance,
              client: context.read(),
              databaseService: context.read(),
            ),
      ),
    ];
