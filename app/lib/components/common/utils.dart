import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('components/common/utils');

class ImageComponent extends StatelessWidget {
  const ImageComponent(this.src, {super.key, this.width, this.height});

  final double? width;
  final double? height;
  final String src;
  @override
  Widget build(BuildContext context) {
    _log.info(src);
    var prefix = '';
    if (src == "") {
      return Icon(Icons.image, size: width);
    }
    if (src.startsWith('/')) {
      // TODO(duncan): Update with the actual
      // server address.
      prefix = 'http://localhost:8080';
    }
    return Image.network(
      '$prefix$src',
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.image, size: width);
      },
    );
  }
}
