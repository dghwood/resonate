import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:ui' as ui;

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
            icon: Icon(Icons.save),
            onPressed: () {
              print('${image.width}, ${image.height}');
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
                // boundaryMargin: EdgeInsets.all(20),
                // minScale: 1.0,
                // maxScale: 4.0,
                child: image,
              ),
              // Positioned.fromRect(
              //   rect: cropRect,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.red, width: 2),
              //     ),
              //   ),
              // ),
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
      body: Center(child: Image.network(imageUrl, width: 300, height: 300)),
      floatingActionButton: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image == null) return;
          final imageBytes = await image.readAsBytes();

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
    return GestureDetector(
      child: Image.network(
        imageUrl,
        height: 150,
        width: 150,
        cacheHeight: 300,
        cacheWidth: 300,
      ),
      onTap: () {
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
