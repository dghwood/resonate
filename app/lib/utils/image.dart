/* 
  https://pub.dev/packages/image

  use this to be able to convert to jpeg. 
*/
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Uint8List toJpeg(int width, int height, ByteBuffer byteBuffer) {
  final newImage = img.Image.fromBytes(
    width: width,
    height: height,
    bytes: byteBuffer,
  );
  return img.encodeJpg(newImage);
}
