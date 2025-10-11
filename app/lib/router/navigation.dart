import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('Navigate');

class Routes {
  static const home = '/';
  static const signIn = '/sign-in';
  static const profile = '/profile';
  static const search = '/search';
  static const podcast = '/podcast/:id';
  static const settings = '/settings';
  static const loading = '/loading';
  static const editProfile = '/profile/edit';
  static const publicProfile = '/profile/:id';
}

class Navigate {
  Navigate(BuildContext context) : _context = context;
  final BuildContext _context;

  void reset() => _context.go(Routes.home);
  void toHome() => _context.push(Routes.home);
  void toLoading() => _context.go(Routes.loading);
  void toSettings() => _context.push(Routes.settings);
  void toSignin() => _context.push(Routes.signIn);
  void toProfilePage() => _context.push(Routes.profile);
  void toPodcast(String id) =>
      _context.push(Routes.podcast.replaceFirst(':id', id));
  void toSearch() => _context.push(Routes.search);
  void editProfile() => _context.push(Routes.editProfile);
  void toPublicProfile(String id) =>
      _context.push(Routes.publicProfile.replaceFirst(':id', id));
}
