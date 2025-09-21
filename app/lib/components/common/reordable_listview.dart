import 'package:flutter/material.dart';

class ReordableListviewComponent<T> extends StatefulWidget {
  const ReordableListviewComponent({
    super.key,
    required this.items,
    required this.builder,
    required this.onReorder,
  });

  final List<T> items;
  final Widget Function(T) builder;
  final Future<void> Function(int oldIndex, int newIndex) onReorder;

  @override
  State<ReordableListviewComponent<T>> createState() =>
      _ReordableListviewComponentState<T>();
}

class _ReordableListviewComponentState<T>
    extends State<ReordableListviewComponent<T>> {
  @override
  Widget build(BuildContext context) {
    // Consider moving this to .builder implementation for long lists.
    return ReorderableListView(
      buildDefaultDragHandles: true,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          var item = widget.items.removeAt(oldIndex);
          widget.items.insert(newIndex, item);
          // TODO(duncan): This is async, so in theory I should check it succeeded and if not revert
          widget.onReorder(oldIndex, newIndex);
          // And update the code
        });
      },
      children: widget.items.map((item) => widget.builder(item)).toList(),
    );
  }
}
