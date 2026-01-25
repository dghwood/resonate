import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
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

class ImageComponent extends StatelessWidget {
  const ImageComponent(
    this.src, {
    super.key,
    this.width,
    this.height,
    this.radius = 0,
  });

  final double? width;
  final double? height;
  final double radius;
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
      prefix = BASE_URL;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '$prefix$src',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          _log.warning(error);
          return Icon(Icons.image, size: width);
        },
      ),
    );
  }
}

class ExpandableTextComponent extends StatefulWidget {
  /* Expandable Text Component

    Limits the text to a certain number of lines. 
    And expands on tap.
  */
  const ExpandableTextComponent({
    super.key,
    required this.text,
    this.style,
    this.maxLines = 3,
  });

  final String text;
  final TextStyle? style;
  final int maxLines;

  @override
  State<ExpandableTextComponent> createState() =>
      _ExpandableTextComponentState();
}

class _ExpandableTextComponentState extends State<ExpandableTextComponent> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: expanded ? null : widget.maxLines,
        overflow: expanded ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
