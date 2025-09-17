/* File 

  * Implementation based on filesystem for iOS / Android 
 * Implementation based on IndexDb for Web 
*/

import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class AbstractFile {
  AbstractFile(this.path);
  final String path;
  Future<void> openWrite();
  void write(List<int> bytes);
  Future<void> cancelWrite();
  Future<void> closeWrite();
}

class FilesystemFile implements AbstractFile {
  FilesystemFile(this.path);

  @override
  final String path;

  File? _file;
  IOSink? _writeSink;

  @override
  Future<void> openWrite() async {
    final cacheDirectory = await getApplicationCacheDirectory();
    final fullPath = '${cacheDirectory.path}/$path';
    _file = File(fullPath);
    _writeSink = _file!.openWrite();
  }

  @override
  void write(List<int> bytes) {
    _writeSink?.add(bytes);
  }

  @override
  Future<void> cancelWrite() async {
    await _writeSink?.close();
    if (await _file!.exists()) {
      await _file!.delete();
    }
  }

  Future<void> closeWrite() async {
    await _writeSink?.close();
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
  Future<void> cancelWrite() async {
    // Just clear the buffer, no file has been written to yet.
    _bytesBuffer = [];
  }

  Future<void> closeWrite() async {
    // since to DB
  }
}
