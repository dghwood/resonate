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

  // but the scale of the transformed image is 300x300
  var ratio = 1.0;
  if (width > height) {
    ratio = width / 300.0;
  } else {
    ratio = height / 300.0;
  }

  print('image dimensions: $width, $height');

  final Rect transformedRect = Rect.fromLTWH(
    -dx * ratio,
    -dy * ratio,
    width / scale,
    height / scale,
  );

  print(
    'transformedRect: $dx, $dy, ${transformedRect.width}, ${transformedRect.height}',
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

class AddPhotoComponent extends StatefulWidget {
  final Function(String) onPhotoSelected;

  const AddPhotoComponent({super.key, required this.onPhotoSelected});

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhotoComponent> {
  String? _imagePath;
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // You can read as bytes here and upload to server.
    if (image != null) {
      _imageBytes = await image.readAsBytes();
      setState(() {
        _imagePath = image.path;
      });
      widget.onPhotoSelected(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Image? image;
    // if (_imagePath != null) {
    //   if (kIsWeb) {
    //     image = Image.network(
    //       _imagePath!,
    //       height: 150,
    //       width: 150,
    //       fit: BoxFit.cover,
    //     );
    //   } else {
    //     // For mobile platforms, use File
    //     image = Image.file(
    //       File(_imagePath!),
    //       height: 150,
    //       width: 150,
    //       fit: BoxFit.cover,
    //     );
    //   }
    // }
    return Column(
      children: [
        if (_imageBytes != null)
          CropImageComponent(
            imageBytes: _imageBytes!,
            onCropComplete: (Uint8List croppedBytes) {
              // Handle the cropped image bytes
              widget.onPhotoSelected('Cropped Image');
            },
          ),
        ElevatedButton(onPressed: _pickImage, child: Text('Upload Photo')),
      ],
    );
  }
}

class CropImageComponent extends StatefulWidget {
  final Uint8List imageBytes;
  final Function(Uint8List) onCropComplete;

  const CropImageComponent({
    super.key,
    required this.imageBytes,
    required this.onCropComplete,
  });

  @override
  _CropImageComponentState createState() => _CropImageComponentState();
}

class _CropImageComponentState extends State<CropImageComponent> {
  late TransformationController _transformationController;
  late Rect _cropRect;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _cropRect = Rect.fromLTWH(50, 50, 200, 200); // Default crop area
  }

  Future<void> _cropImage() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Matrix4 matrix = _transformationController.value;

    final double scale = matrix.getMaxScaleOnAxis();
    final double dx = matrix.getTranslation().x / scale;
    final double dy = matrix.getTranslation().y / scale;

    final Rect transformedRect = Rect.fromLTWH(
      _cropRect.left - dx,
      _cropRect.top - dy,
      _cropRect.width / scale,
      _cropRect.height / scale,
    );

    final ByteData? byteData = await widget.imageBytes.buffer.asByteData();
    if (byteData != null) {
      final Uint8List croppedBytes = byteData.buffer.asUint8List(
        transformedRect.left.toInt(),
        transformedRect.width.toInt(),
      );
      widget.onCropComplete(croppedBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: _transformationController,
          boundaryMargin: EdgeInsets.all(20),
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.memory(widget.imageBytes, fit: BoxFit.cover),
        ),
        Positioned.fromRect(
          rect: _cropRect,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: _cropImage,
            child: Text('Crop Image'),
          ),
        ),
      ],
    );
  }
}
