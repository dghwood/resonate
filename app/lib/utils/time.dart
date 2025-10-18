// All timestamps will be in UTC
import 'package:fixnum/fixnum.dart';

DateTime fromProtoTimestamp(Int64 timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(
    timestamp.toInt() * 1000,
    isUtc: true,
  );
}

String formatTimeAgo(DateTime datetime) {
  String padWith0(int n) => n.toString().padLeft(2, '0');
  int now = DateTime.now().millisecondsSinceEpoch;
  int then = datetime.millisecondsSinceEpoch;
  Duration diff = Duration(milliseconds: now - then);

  if (diff.inDays >= 30) {
    return '${padWith0(datetime.year)}-${padWith0(datetime.month)}-${padWith0(datetime.day)}';
  }
  if (diff.inDays >= 1) {
    String s = diff.inDays == 1 ? '' : 's';
    return '${diff.inDays} day$s ago';
  }
  if (diff.inHours >= 1) {
    String s = diff.inHours == 1 ? '' : 's';
    return '${diff.inHours} hour$s ago';
  }

  String s = diff.inMinutes == 1 ? '' : 's';
  return '${diff.inMinutes} min$s ago';
}

/* _formatDuration 

  Conviencence function to format Durations into 00:00:00 
*/
String formatDurationHHMMSS(Duration duration) {
  String padWith0(int n) => n.toString().padLeft(2, '0');
  String hours = padWith0(duration.inHours);
  String mins = padWith0(duration.inMinutes.remainder(60));
  String seconds = padWith0(duration.inSeconds.remainder(60));

  return '$hours:$mins:$seconds';
}

String formatDuration(Duration duration) {
  var hours = duration.inHours;
  var minutes = duration.inMinutes;

  if (hours > 0) {
    return '${hours}h${minutes % 60}m';
  }
  if (minutes > 0) {
    return '${minutes}mins';
  }
  return '1min';
}
