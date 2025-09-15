import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final Logger _log = Logger('utils/download');

Stream<double> downloadFile(String url, String filePath) async* {

  _log.info('Starting download for $url to $filePath');
  final file = File(filePath);
  final request = http.Request('GET', Uri.parse(url));
  final response = await http.Client().send(request);
  final contentLength = response.contentLength;

  if (response.statusCode == 200) {
    var bytesReceived = 0;
    final sink = file.openWrite();
    await for (var chunk in response.stream) {
      sink.add(chunk);
      bytesReceived += chunk.length;
      if (contentLength != null && contentLength > 0) {
        yield bytesReceived / contentLength;
      }
    }
    await sink.close();
    _log.info('Download complete for $url');
  } else {
    _log.severe('Failed to download file from $url. Status code: ${response.statusCode}');
    throw Exception('Failed to download file: ${response.statusCode}');
  }
}
