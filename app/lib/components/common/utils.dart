import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent(this.src, {super.key, this.width, this.height});

  final double? width;
  final double? height;
  final String src;
  @override
  Widget build(BuildContext context) {
    if (src == "") {
      return Icon(Icons.image, size: width);
    }
    return Image.network(
      src,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.image, size: width);
      },
    );
  }
}
