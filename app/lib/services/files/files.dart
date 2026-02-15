import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('services/files/file');

class FileService {
  static Future<Uint8List> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return Uint8List(0);
    return await image.readAsBytes();
  }

  static Future<Uint8List> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return Uint8List(0);
    return await image.readAsBytes();
  }

  static Future<Uint8List> pickOpmlFiles() async {
    _log.info('picking opml file');
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['xml', 'opml'],
    );

    if (result != null && result.files.isNotEmpty) {
      var file = result.files.single;
      _log.info('found file: ${file.name}');
      var bytes = file.bytes;
      if (bytes == null) {
        _log.warning('file empty');
        throw Exception('empty file');
      }
      return bytes;
    }
    // Return empty bytes otherwise
    return Uint8List(0);
  }
}
