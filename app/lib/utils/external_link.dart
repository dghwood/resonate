import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

final Logger _log = Logger('utils/external_link');

Future<bool> openBrowser(String url) async {
  try {
    return await launchUrl(Uri.parse(url));
  } on Exception catch (e) {
    _log.info(e);
    return false;
  }
}
