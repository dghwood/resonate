/* File 

  * Implementation based on filesystem for iOS / Android 
 * Implementation based on IndexDb for Web 
*/

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

Logger _log = Logger('services/file');

abstract class AbstractFile {
  AbstractFile(this.path);
  final String path;
  Future<void> openWrite();
  void write(List<int> bytes);
  Future<void> cancelWrite();
  Future<void> closeWrite();
  Future<void> delete();
}

class FilesystemFile implements AbstractFile {
  FilesystemFile(this.path);

  @override
  final String path;

  File? _file;
  IOSink? _writeSink;

  Future<void> _defineFile() async {
    final cacheDirectory = await getApplicationCacheDirectory();
    final fullPath = '${cacheDirectory.path}/$path';
    _file = File(fullPath);
  }

  @override
  Future<void> openWrite() async {
    await _defineFile();
    _writeSink = _file!.openWrite();
    _log.info('opening ${_file!.path} for write');
  }

  @override
  void write(List<int> bytes) {
    _writeSink!.add(bytes);
  }

  @override
  Future<void> delete() async {
    _log.info('delete');
    await _defineFile();
    if (await _file!.exists()) {
      _log.info('deleting existing file $path');
      await _file!.delete();
      _log.info('deleted');
    } else {
      _log.info('file does not exist $path');
    }
  }

  @override
  Future<void> cancelWrite() async {
    await _writeSink?.close();
    if (await _file!.exists()) {
      await _file!.delete();
    }
  }

  @override
  Future<void> closeWrite() async {
    await _writeSink!.close();
    _log.info('closing ${_file!.path} for write');
  }
}

class IndexDbFile implements AbstractFile {
  IndexDbFile(this.path);

  @override
  final String path;

  List<int> _bytesBuffer = [];

  @override
  Future<void> openWrite() async {
    _bytesBuffer = [];
  }

  @override
  void write(List<int> bytes) {
    _bytesBuffer.addAll(bytes);
  }

  @override
  Future<void> delete() async {
    throw UnimplementedError('delete not implemented');
  }

  @override
  Future<void> cancelWrite() async {
    // Just clear the buffer, no file has been written to yet.
    _bytesBuffer = [];
  }

  Future<void> closeWrite() async {
    // since to DB
  }
}
