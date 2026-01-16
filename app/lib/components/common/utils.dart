import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/services/image_cache_service.dart';
import 'package:resonate/utils/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

final Logger _log = Logger('components/common/utils');

enum ButtonState { loading, error, on, off }

class OutlinedButtonComponent extends StatelessWidget {
  const OutlinedButtonComponent({
    super.key,
    required this.child,
    required this.onPressed,
    required this.icon,
    this.showIcon = false,
    this.state = ButtonState.off,
  });
  final ButtonState state;
  final Widget child;
  final Icon icon;
  final Function() onPressed;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return showIcon
        ? IconButton(icon: icon, onPressed: onPressed)
        : OutlinedButton(onPressed: onPressed, child: child);
  }
}

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

class ProfileImageComponent extends StatelessWidget {
  const ProfileImageComponent(
    this.src, {
    super.key,
    this.width = 24,
    this.height = 24,
  });

  final String src;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width > height ? width : height),
      child: ImageComponent(src, width: width, height: height),
    );
  }
}

class ImageComponent extends StatefulWidget {
  const ImageComponent(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.radius = 0,
    this.cacheWidth,
    this.cacheHeight,
    this.ttl = const Duration(days: 7),
  });

  final double? width;
  final double? height;
  final double radius;
  final String src;
  final int? cacheWidth;
  final int? cacheHeight;
  final Duration ttl;

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  Uint8List? _bytes;
  bool _isLoading = true;
  String? _lastLoadedUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant ImageComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src ||
        oldWidget.cacheWidth != widget.cacheWidth ||
        oldWidget.cacheHeight != widget.cacheHeight) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    final currentUrl = widget.src;
    _lastLoadedUrl = currentUrl;

    if (kIsWeb) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (currentUrl.isEmpty) {
      setState(() {
        _isLoading = false;
        _bytes = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var prefix = '';
    if (currentUrl.startsWith('/')) {
      prefix = BASE_URL;
    }
    final fullUrl = '$prefix$currentUrl';

    try {
      final bytes = await ImageCacheService().loadImage(
        fullUrl,
        cacheWidth: widget.cacheWidth,
        cacheHeight: widget.cacheHeight,
        ttl: widget.ttl,
      );
      if (mounted && _lastLoadedUrl == currentUrl) {
        setState(() {
          _bytes = bytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      _log.warning('Error in ImageComponent._loadImage: $e');
      if (mounted && _lastLoadedUrl == currentUrl) {
        setState(() {
          _isLoading = false;
          _bytes = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.src == "") {
      return Icon(Icons.image, size: widget.width);
    }

    if (kIsWeb) {
      var prefix = '';
      if (widget.src.startsWith('/')) {
        prefix = BASE_URL;
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: Image.network(
          '$prefix${widget.src}',
          width: widget.width,
          height: widget.height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            _log.warning(error);
            return Icon(Icons.image, size: widget.width);
          },
        ),
      );
    }

    if (_isLoading) {
      return SkeletonLoadingComponent(
        child: Container(
          width: widget.width,
          height: widget.height,
          color: Colors.grey[300],
        ),
      );
    }

    if (_bytes == null) {
      return Icon(Icons.image, size: widget.width);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Image.memory(
        _bytes!,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          _log.warning(error);
          return Icon(Icons.image, size: widget.width);
        },
      ),
    );
  }
}
