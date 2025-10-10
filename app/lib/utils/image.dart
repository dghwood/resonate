/* 
  https://pub.dev/packages/image

  use this to be able to convert to jpeg. 
*/
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Uint8List toJpeg(double width, double height, ByteBuffer byteBuffer) {
  print('toJpeg');
  final newImage = img.Image.fromBytes(
    width: width.toInt(),
    height: height.toInt(),
    bytes: byteBuffer,
  );
  print('encode');
  return img.encodeJpg(newImage, quality: 90);
}

/* 
DartError: RangeError (end): Invalid value: Not in inclusive range 351000..351529: 352350
    at Object.throw_ [as throw] (http://localhost:63715/dart_sdk.js:3803:11)
    at RangeError.checkValidRange (http://localhost:63715/dart_sdk.js:155436:21)
    at Uint8List.sublistView (http://localhost:63715/dart_sdk.js:73155:29)
    at new dartDevEmbedder.defineLibrary.image.Image.fromBytes (http://localhost:63715/packages/image/src/image/pixel_uint4.dart.lib.js:11538:39)
    at Proxy.toJpeg (http://localhost:63715/packages/resonate/utils/image.dart.lib.js:35:20)
    at http://localhost:63715/packages/resonate/components/common/add_photo.dart.lib.js:493:42
    at http://localhost:63715/dart_sdk.js:40597:13
    at http://localhost:63715/dart_sdk.js:40607:7
    at http://localhost:63715/dart_sdk.js:40574:42
    at _RootZone.runUnary (http://localhost:63715/dart_sdk.js:39575:59)
    at _FutureListener.handleValue (http://localhost:63715/dart_sdk.js:32887:26)
    at handleValueCallback (http://localhost:63715/dart_sdk.js:33523:47)
    at _Future._propagateToListeners (http://localhost:63715/dart_sdk.js:33561:15)
    at [_completeWithValue] (http://localhost:63715/dart_sdk.js:33380:21)
    at http://localhost:63715/dart_sdk.js:33426:33
    at Object._microtaskLoop (http://localhost:63715/dart_sdk.js:40957:43)
    at Object._startMicrotaskLoop (http://localhost:63715/dart_sdk.js:40964:13)
    at tear (http://localhost:63715/dart_sdk.js:3848:46)
    at http://localhost:63715/dart_sdk.js:33848:73
*/
