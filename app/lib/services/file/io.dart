import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'file.dart';

Logger _log = Logger('services/file');

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
