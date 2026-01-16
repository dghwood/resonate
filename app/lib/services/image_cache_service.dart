import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

final _log = Logger('services/image_cache_service');

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();

  static const String _cacheFolderName = 'image-cache';
  final Map<String, Future<Uint8List?>> _inFlightRequests = {};

  Future<String> get _cacheDirPath async {
    final cacheDir = await getApplicationCacheDirectory();
    final path = '${cacheDir.path}/$_cacheFolderName';
    final directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return path;
  }

  String _generateKey(String url, int? width, int? height) {
    final key = '$url-$width-$height';
    return md5.convert(utf8.encode(key)).toString();
  }

  Future<Uint8List?> loadImage(
    String url, {
    int? cacheWidth,
    int? cacheHeight,
    Duration ttl = const Duration(days: 7),
  }) async {
    final key = _generateKey(url, cacheWidth, cacheHeight);

    if (_inFlightRequests.containsKey(key)) {
      _log.info('Joining in-flight request for: $url');
      return _inFlightRequests[key];
    }

    final future = _loadImageInternal(url, cacheWidth, cacheHeight, ttl, key);
    _inFlightRequests[key] = future;

    try {
      return await future;
    } finally {
      _inFlightRequests.remove(key);
    }
  }

  Future<Uint8List?> _loadImageInternal(
    String url,
    int? cacheWidth,
    int? cacheHeight,
    Duration ttl,
    String key,
  ) async {
    final cachePath = await _cacheDirPath;
    final file = File('$cachePath/$key');

    if (await file.exists()) {
      final lastModified = await file.lastModified();
      if (DateTime.now().difference(lastModified) < ttl) {
        _log.info('Loading from cache: $url');
        return await file.readAsBytes();
      } else {
        _log.info('Cache expired for: $url');
      }
    }

    // Try network
    try {
      _log.info('Downloading: $url');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bytes = response.bodyBytes;

        // Resize if requested
        if (cacheWidth != null || cacheHeight != null) {
          bytes = await Isolate.run(() {
            final image = img.decodeImage(bytes);
            if (image == null) return bytes;
            final resized = img.copyResize(
              image,
              width: cacheWidth,
              height: cacheHeight,
            );
            // Support transparency by checking if image has alpha
            if (image.hasAlpha) {
              return Uint8List.fromList(img.encodePng(resized));
            } else {
              return Uint8List.fromList(img.encodeJpg(resized));
            }
          });
        }

        await file.writeAsBytes(bytes);
        return bytes;
      } else {
        _log.warning(
          'Failed to download image: $url (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      _log.warning('Error downloading image: $url - $e');
    }

    // Fallback to cache even if expired
    if (await file.exists()) {
      _log.info('Falling back to expired cache: $url');
      return await file.readAsBytes();
    }

    return null;
  }
}
