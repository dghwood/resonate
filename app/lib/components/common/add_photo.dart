import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

import 'dart:ui' as ui;

final Logger _log = Logger('components/common/add_photo');

class ProfileImage extends ChangeNotifier {
  ProfileImage();
  Uint8List? imageBytes;
  Uint8List? newImageBytes;

  Future<bool> transform(
    Matrix4 transformationMatrix, {
    double targetSize = 450,
  }) async {
    if (imageBytes == null) return false;
    final ui.Image image = await decodeImageFromList(imageBytes!);
    final originalWidth = image.width.toDouble();
    final originalHeight = image.height.toDouble();

    // Get the max side & scale
    final maxLength =
        originalWidth > originalHeight ? originalWidth : originalHeight;
    final scale = targetSize / maxLength;

    // Center the image
    final paddingX = (maxLength - originalWidth) / 2;
    final paddingY = (maxLength - originalHeight) / 2;

    final recorder = ui.PictureRecorder();
    // create the canvas to the target size
    final canvasSize = Rect.fromLTWH(0, 0, targetSize, targetSize);
    final ui.Canvas canvas = ui.Canvas(recorder, canvasSize);
    // canvas.save();
    final matrix = transformationMatrix;
    // scale the coordinates to the size of the original image.
    matrix.scaleByDouble(scale, scale, scale, 1.0);
    // place the image offset in the center
    matrix.translateByDouble(paddingX, paddingY, 0, 1.0);

    canvas.transform(matrix.storage);
    canvas.drawImage(image, Offset.zero, Paint());
    // canvas.restore();

    var finalImage = await recorder.endRecording().toImage(
      canvasSize.width.toInt(),
      canvasSize.height.toInt(),
    );

    var byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return false;
    // TODO(duncan): Fix this, throws an error but would reduce
    // the image size significantly.
    // newImageBytes = toJpeg(
    //   canvasSize.width,
    //   canvasSize.height,
    //   byteData.buffer,
    // );
    newImageBytes = byteData.buffer.asUint8List();
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
  EditableProfilePhotoComponent({super.key, required this.onImageUpdated});

  final PageController pageController = PageController();
  final ProfileImage profileImage = ProfileImage();
  final transformationController = TransformationController();
  final double targetSize = 450;
  final Future<ApiResult<bool>> Function(Uint8List imageBytes) onImageUpdated;

  void onSave() async {
    if (await profileImage.transform(
      transformationController.value,
      targetSize: targetSize,
    )) {
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void onRotate(double degrees) {
    var matrix = Matrix4.identity();

    final originalCenter = vector_math.Vector3(
      targetSize / 2,
      targetSize / 2,
      0,
    );

    matrix.translateByVector3(originalCenter);
    matrix.rotateZ(degrees);
    matrix.translateByVector3(-originalCenter);
    matrix.multiply(transformationController.value);

    transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile photo'),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: onSave)],
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(targetSize),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(targetSize),
                            ),
                            child: SizedBox(
                              width: targetSize,
                              height: targetSize,
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
                          spacing: 16,
                          children: [
                            IconButton(
                              icon: Icon(Icons.rotate_left),
                              onPressed: () => onRotate(-math.pi / 2),
                            ),
                            IconButton(
                              icon: Icon(Icons.rotate_right),
                              onPressed: () => onRotate(math.pi / 2),
                            ),
                          ],
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
                if (profileImage.newImageBytes == null) {
                  return Text('No image selected');
                }
                return FutureBuilder(
                  future: onImageUpdated(profileImage.newImageBytes!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingSpinnerComponent();
                    }
                    var result = snapshot.requireData;
                    switch (result) {
                      case ApiOk():
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                        break;
                      case ApiError():
                        // TODO(duncan): Retry?
                        return Text('Error uploading image: ${result.error}');
                    }
                    return SizedBox(
                      width: targetSize,
                      height: targetSize,
                      child: Image.memory(profileImage.newImageBytes!),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
