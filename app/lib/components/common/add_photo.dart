import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:resonate/components/common/loading.dart';

import 'dart:ui' as ui;

import 'package:resonate/components/common/utils.dart';

final Logger _log = Logger('components/common/add_photo');

class ProfileImage extends ChangeNotifier {
  ProfileImage();
  Uint8List? imageBytes;
  Uint8List? newBytes;

  Future<bool> transform(TransformationController controller) async {
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

    var transformationMatrix = controller.value;
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

Future<Uint8List> cropImage(
  Uint8List imageBytes,
  Matrix4 transformationMatrix,
  // Rect cropRect,
) async {
  final double scale = transformationMatrix.getMaxScaleOnAxis();
  final double dx = transformationMatrix.getTranslation().x / scale;
  final double dy = transformationMatrix.getTranslation().y / scale;

  print('transform: $dx, $dy, $scale');

  final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ui.Image image = frameInfo.image;

  // These are the raw dimensions of the image
  var width = image.width;
  var height = image.height;

  // but this gets scaled and constrained in the viewer to 300x300
  // So there is extra height | width not in the original image.
  var coordRatio = 1.0;
  var longestSide = width;
  if (width > height) {
    coordRatio = width / 300.0;
  } else {
    coordRatio = height / 300.0;
    longestSide = height;
  }

  print('image dimensions: $width, $height');

  final Rect transformedRect = Rect.fromLTWH(
    -dx * coordRatio,
    -dy * coordRatio,
    300 * coordRatio / scale,
    300 * coordRatio / scale,
  );

  print(
    'transformedRect: ${transformedRect.left}, ${transformedRect.top}, ${transformedRect.width}, ${transformedRect.height}',
  );

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint();

  canvas.drawImageRect(
    image,
    transformedRect,
    Rect.fromLTWH(0, 0, transformedRect.width, transformedRect.height),
    paint,
  );

  final ui.Image croppedImage = await recorder.endRecording().toImage(
    transformedRect.width.toInt(),
    transformedRect.height.toInt(),
  );

  print('${croppedImage.width}, ${croppedImage.height}');
  final ByteData? byteData = await croppedImage.toByteData(
    format: ui.ImageByteFormat.png,
  );
  if (byteData != null) {
    return byteData.buffer.asUint8List();
  }
  throw Exception('Failed to crop image');
}

class ProfilePhotoFinalComponent extends StatelessWidget {
  const ProfilePhotoFinalComponent({super.key, required this.imageBytes});

  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Photo')),
      body: Container(
        child: Center(child: Image.memory(imageBytes, width: 300, height: 300)),
      ),
    );
  }
}

class ProfilePhotoEditComponent extends StatelessWidget {
  const ProfilePhotoEditComponent({super.key, required this.imageBytes});
  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    var transformationController = TransformationController();
    var cropRect = Rect.fromLTWH(50, 50, 200, 200); // Default crop area
    var image = Image.memory(imageBytes, width: 300, height: 300);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Photo'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              var ib = cropImage(imageBytes, transformationController.value);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FutureBuilder(
                      future: ib,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ProfilePhotoFinalComponent(
                            imageBytes: snapshot.data!,
                          );
                        }
                        return Text('Cropping..');
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              InteractiveViewer(
                constrained: false,
                transformationController: transformationController,
                child: image,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePhotoPreviewComponent extends StatelessWidget {
  const ProfilePhotoPreviewComponent({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Photo')),
      body: Center(child: ImageComponent(imageUrl, width: 300, height: 300)),
      floatingActionButton: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image == null) return;
          final imageBytes = await image.readAsBytes();

          // TODO(duncan): Fix this async gap..
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ProfilePhotoEditComponent(imageBytes: imageBytes);
              },
            ),
          );
        },
      ),
    );
  }
}

class ProfilePhotoComponent extends StatelessWidget {
  const ProfilePhotoComponent({super.key});

  final String imageUrl =
      'https://www.eharmony.com/wp-content/uploads/2013/06/eight-key-qualities-to-look-for-in-a-guy.jpg';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 150,
      icon: Icon(Icons.photo),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProfilePhotoPreviewComponent(imageUrl: imageUrl);
            },
          ),
        );
      },
    );
  }
}

class EditableProfilePhotoComponent extends StatelessWidget {
  EditableProfilePhotoComponent({super.key});

  final PageController pageController = PageController();
  final ProfileImage profileImage = ProfileImage();

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
                    var transformationController = TransformationController();
                    return Column(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: InteractiveViewer(
                            constrained: false,
                            transformationController: transformationController,
                            child: Image.memory(
                              imageBytes!,
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                        TextButton(
                          child: Text("Save"),
                          onPressed: () async {
                            if (await profileImage.transform(
                              transformationController,
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
                  width: 300,
                  height: 300,
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
