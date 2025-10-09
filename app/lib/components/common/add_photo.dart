import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

import 'dart:ui' as ui;

final Logger _log = Logger('components/common/add_photo');

class ProfileImage extends ChangeNotifier {
  ProfileImage();
  Uint8List? imageBytes;
  Uint8List? newBytes;

  Future<bool> transform2(
    Matrix4 transformationMatrix, {
    double targetSize = 300,
  }) async {
    _log.info('transform2');
    if (imageBytes == null) return false;
    final ui.Image image = await decodeImageFromList(imageBytes!);
    final originalWidth = image.width.toDouble();
    final originalHeight = image.height.toDouble();
    final maxLength =
        originalWidth > originalHeight ? originalWidth : originalHeight;
    final scale = targetSize / maxLength;

    _log.info('original image dimensions: $originalWidth, $originalHeight');

    // Center the image
    final paddingX = (maxLength - originalWidth) / 2;
    final paddingY = (maxLength - originalHeight) / 2;
    _log.info('padding: $paddingX, $paddingY');
    _log.info('scale: $scale');

    final recorder = ui.PictureRecorder();
    // create the canvas to the target size
    final canvasSize = Rect.fromLTWH(0, 0, targetSize, targetSize);
    final ui.Canvas canvas = ui.Canvas(recorder, canvasSize);
    // give it a blue background, so you can see the actual size.
    canvas.drawRect(canvasSize, Paint()..color = Colors.blue);
    canvas.save();
    final matrix = transformationMatrix; // Matrix4.identity();
    // scale the coordinates to the size of the original image.
    matrix.scaleByDouble(scale, scale, scale, 1.0);
    // place the image offset in the center
    matrix.translateByDouble(paddingX, paddingY, 0, 1.0);

    canvas.transform(matrix.storage);
    // canvas.transform(transformationMatrix.storage);

    // Before I draw the image, i need to transform
    canvas.drawImage(image, Offset.zero, Paint());
    canvas.restore();
    // Translate the matrix to the default preview coords.
    // final matrix = Matrix4.identity();
    // // Scale up to the original size
    // // matrix.scaleByDouble(scale, scale, scale, 1.0);
    // // Put it into the center
    // matrix.translateByDouble(paddingX, paddingY, 0, 1.0);
    // _log.info(matrix);

    var finalImage = await recorder.endRecording().toImage(
      canvasSize.width.toInt(),
      canvasSize.height.toInt(),
    );
    var byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return false;
    newBytes = byteData.buffer.asUint8List();
    return true;
  }

  Future<bool> transform(Matrix4 transformationMatrix) async {
    if (imageBytes == null) return false;

    final ui.Codec codec = await ui.instantiateImageCodec(
      imageBytes!,
      // targetHeight: 300,
      // targetWidth: 300,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;
    // TODO(duncan): To clean this up, I should just paint
    // this image onto a canvas of the right size, including the padding.
    // Another idea is that you do all the calculations first and then
    // load the right size image to end up at 300x300
    _log.info('original image dimensions: ${image.width}, ${image.height}');

    final double scale = transformationMatrix.getMaxScaleOnAxis();
    // transformed image dimensions
    double viewerScale = 1;
    double paddingX = 0;
    double paddingY = 0;
    if (image.width > image.height) {
      viewerScale = image.width / (300);
      paddingY = 300 - image.height / viewerScale;
    } else {
      viewerScale = image.height / (300);
      paddingX = 300 - image.width / viewerScale;
    }
    _log.info(
      'viewerScale: $viewerScale scale: $scale, combined: ${viewerScale / scale}',
    );
    // But bear in mind there is padding around the short dimension
    final double dx =
        viewerScale /
        scale *
        (paddingX / 2 + transformationMatrix.getTranslation().x);
    final double dy =
        viewerScale /
        scale *
        (paddingY / 2 + transformationMatrix.getTranslation().y);

    _log.info('transform: $dx, $dy, $viewerScale');

    final Rect srcRect = Rect.fromLTWH(
      -dx,
      -dy,
      viewerScale * 300 / scale,
      viewerScale * 300 / scale,
    );
    final Rect dstRect = Rect.fromLTWH(0, 0, srcRect.width, srcRect.height);

    _log.info('size: ${srcRect.width}, ${srcRect.height}}');

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint();

    canvas.drawImageRect(image, srcRect, dstRect, paint);

    final ui.Image croppedImage = await recorder.endRecording().toImage(
      dstRect.width.toInt(),
      dstRect.height.toInt(),
    );
    final ByteData? byteData = await croppedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    if (byteData == null) {
      _log.info('byteData is null');
      return false;
    }
    newBytes = byteData.buffer.asUint8List();
    notifyListeners();
    return true;
  }

  Future<bool> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return false;
    imageBytes = await image.readAsBytes();
    notifyListeners();
    return true;
  }
}

class EditableProfilePhotoComponent extends StatelessWidget {
  EditableProfilePhotoComponent({super.key});

  final PageController pageController = PageController();
  final ProfileImage profileImage = ProfileImage();
  final transformationController = TransformationController();
  final double targetSize = 450;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile photo'),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: () {})],
      ),
      body: Center(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            // Edit Image
            FutureBuilder(
              future: profileImage.pickImage(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return LoadingSpinnerComponent();
                }
                if (asyncSnapshot.data == false) {
                  return Text('No image selected');
                }
                return ListenableBuilder(
                  listenable: profileImage,
                  builder: (context, _) {
                    var imageBytes = profileImage.imageBytes;
                    if (profileImage.imageBytes == null) {
                      return Text('No image available');
                    }
                    transformationController.value = Matrix4.identity();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(targetSize),
                          ),
                          child: SizedBox(
                            width: targetSize,
                            height: targetSize,
                            child: Container(
                              color: Colors.blue,
                              child: InteractiveViewer(
                                constrained: false,
                                transformationController:
                                    transformationController,
                                child: Image.memory(
                                  imageBytes!,
                                  width: targetSize,
                                  height: targetSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.rotate_right),
                              onPressed: () {
                                _log.info("rotate");

                                var matrix = Matrix4.identity();

                                final originalCenter = vector_math.Vector3(
                                  targetSize / 2,
                                  targetSize / 2,
                                  0,
                                );

                                matrix.translateByVector3(originalCenter);
                                matrix.rotateZ(math.pi / 2);
                                matrix.translateByVector3(-originalCenter);
                                matrix.multiply(transformationController.value);

                                transformationController.value = matrix;
                              },
                            ),
                          ],
                        ),
                        TextButton(
                          child: Text("Save"),
                          onPressed: () async {
                            if (await profileImage.transform2(
                              transformationController.value,
                              targetSize: targetSize,
                            )) {
                              _log.info('next page');
                              pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            }
                            ;
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListenableBuilder(
              listenable: profileImage,
              builder: (context, _) {
                if (profileImage.newBytes == null) {
                  return Text('No image selected');
                }
                return SizedBox(
                  width: targetSize,
                  height: targetSize,
                  child: Image.memory(profileImage.newBytes!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
