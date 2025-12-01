import 'dart:async';

import 'package:resonate/services/database.dart';

import 'file.dart';

// The 'files' object store needs to be created for this to work.
// This can be done by calling `databaseService.registerStore`
// somewhere during app initialization.
//
// Example:
// databaseService.registerStore('files', (e) {
//   e.database.createObjectStore('files', keyPath: 'path');
// });

class IndexDbFile implements AbstractFile {
  IndexDbFile(this.path, this.databaseService);

  @override
  final String path;
  final AbstractDatabaseService databaseService;

  List<int> _bytesBuffer = [];

  final String _storeName = 'files';

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
    // This assumes that the 'files' object store has 'path' as its keyPath.
    // We can then delete by path.
    await databaseService.deleteValue(_storeName, path);
  }

  @override
  Future<void> cancelWrite() async {
    _bytesBuffer = [];
  }

  @override
  Future<void> closeWrite() async {
    final value = {
      'path': path,
      'bytes': _bytesBuffer,
    };
    await databaseService.setValue(_storeName, value);
  }
}
