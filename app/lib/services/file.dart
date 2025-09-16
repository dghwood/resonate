/* File 

  * Implementation based on filesystem for iOS / Android 
  * Implementation based on IndexDb for Web 
*/

import 'dart:io';

abstract class AbstractFile {
  AbstractFile(this.path);
  final String path;
  void openWrite();
  void write(List<int> bytes);
}

class FilesystemFile implements AbstractFile {
  FilesystemFile(this.path) : _file = File(path);

  @override
  final String path;

  final File _file;
  IOSink? _writeSink;

  @override
  void openWrite() {
    _writeSink = _file.openWrite();
  }

  @override
  void write(List<int> bytes) {
    _writeSink?.add(bytes);
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
  void openWrite() {
    _bytesBuffer = [];
  }

  @override
  void write(List<int> bytes) {
    _bytesBuffer.addAll(bytes);
  }

  Future<void> closeWrite() async {
    // since to DB
  }
}
