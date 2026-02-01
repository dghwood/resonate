import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/models/models.dart';
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

class StackedProfileImageComponent extends StatelessWidget {
  const StackedProfileImageComponent({
    super.key,
    required this.users,
    required this.radius,
    this.borderWidth = 1,
  });
  final Iterable<PublicUser?> users;
  final double radius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return Container();
    return Stack(
      children: [
        SizedBox(
          height: radius,
          width: radius + (users.length - 1) * radius / 2,
        ),
        ...List.generate(users.length, (index) {
          var user = users.elementAt(index);
          return Positioned(
            left: index * radius / 2,
            child: ProfileImageComponent(
              user,
              width: radius,
              height: radius,
              borderWidth: borderWidth,
            ),
          );
        }),
      ],
    );
  }
}

class ProfileImageComponent extends StatelessWidget {
  const ProfileImageComponent(
    this.user, {
    super.key,
    this.width = 24,
    this.height = 24,
    this.borderWidth = 2,
  });

  final PublicUser? user;
  // final String src;
  final double width;
  final double height;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    var radius = width > height ? width : height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth,
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child:
          user != null
              ? ImageComponent(
                user!.imageUrl,
                width: width,
                height: height,
                radius: radius,
              )
              // TODO(duncan): Default to something
              //               better.
              : SizedBox(),
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
    this.errorBuilder,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget Function(BuildContext context)? errorBuilder;
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
      child: Container(
        // width: width,
        // height: height,
        // decoration: BoxDecoration(
        //   color: Colors.white, // Color of the area inside the border
        //   border: Border.all(
        //     color:
        //         Theme.of(
        //           context,
        //         ).colorScheme.primary, // Color of the border line
        //     width: borderWidth, // Thickness of the border line
        //   ),
        //   borderRadius: BorderRadius.circular(radius), // Radius of the corners
        // ),
        color: Theme.of(context).colorScheme.surface,
        child: Image.network(
          '$prefix$src',
          width: width,
          height: height,
          fit: BoxFit.cover,
          // Adding this for mWeb where cross orgin issues are
          // very common
          webHtmlElementStrategy:
              kIsWeb
                  ? WebHtmlElementStrategy.fallback
                  : WebHtmlElementStrategy.never,
          errorBuilder: (context, error, stackTrace) {
            _log.warning(error);
            return errorBuilder != null
                ? errorBuilder!(context)
                : Icon(Icons.error_outline, size: width);
          },
        ),
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

class SwitchComponent extends StatefulWidget {
  const SwitchComponent({
    super.key,
    this.icon,
    this.enabled = false,
    required this.onChanged,
  });

  final Icon? icon;
  final Function(bool enabled) onChanged;
  final bool enabled;

  @override
  State<SwitchComponent> createState() => _SwitchComponentState();
}

class _SwitchComponentState extends State<SwitchComponent> {
  bool? _enabled;
  @override
  Widget build(BuildContext context) {
    var enabled = _enabled ?? widget.enabled;
    var icons = WidgetStateProperty<Icon?>.fromMap(
      <WidgetStatesConstraint, Icon?>{
        WidgetState.selected: widget.icon,
        WidgetState.any: widget.icon,
      },
    );
    return Switch(
      thumbIcon: icons,
      onChanged: (val) {
        setState(() {
          _enabled = val;
          widget.onChanged(val);
        });
      },
      value: enabled,
    );
  }
}

class LogoComponent extends StatelessWidget {
  const LogoComponent({super.key, this.width = 120, this.height = 120});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logo_inverted_512.png",
      width: width,
      height: height,
    );
  }
}
