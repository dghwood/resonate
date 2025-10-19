import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:skeletonizer/skeletonizer.dart';

final Logger _log = Logger('components/common/utils');

class SkeletonLoadingComponent extends StatelessWidget {
  const SkeletonLoadingComponent({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: enabled, child: child);
  }
}

class ImageComponent extends StatelessWidget {
  const ImageComponent(this.src, {super.key, this.width, this.height});

  final double? width;
  final double? height;
  final String src;
  @override
  Widget build(BuildContext context) {
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
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.image, size: width);
      },
    );
  }
}
