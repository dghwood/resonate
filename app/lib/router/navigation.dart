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
}

class Navigate {
  Navigate(BuildContext context) : _context = context;
  final BuildContext _context;

  reset() => _context.go(Routes.home);
  toHome() => _context.push(Routes.home);
  toLoading() => _context.go(Routes.loading);
  toSettings() => _context.push(Routes.settings);
  toSignin() => _context.push(Routes.signIn);
  toProfilePage() => _context.push(Routes.profile);
  toPodcast(String id) => _context.push(Routes.podcast.replaceFirst(':id', id));
  toSearch() => _context.push(Routes.search);
}
