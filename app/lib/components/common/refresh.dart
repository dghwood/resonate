import 'package:flutter/material.dart';

/* RefreshIndicatorComponent 

  Basic wrapper for adding a refresh indicator by 
  extending your component 

  MyComponent extends RefreshIndicatorComponent
*/
abstract class RefreshIndicatorComponent<T> extends StatefulWidget {
  const RefreshIndicatorComponent({super.key, required this.value});

  final T Function() value;
  Widget build(BuildContext context, T value);

  @override
  State<RefreshIndicatorComponent<T>> createState() =>
      _RefreshIndicatorComponentState<T>();
}

class _RefreshIndicatorComponentState<T>
    extends State<RefreshIndicatorComponent<T>> {
  Future<void> onRefresh() async {
    setState(() {
      value = widget.value();
    });
  }

  late T value;
  @override
  void initState() {
    super.initState();
    value = widget.value();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: widget.build(context, value),
    );
  }
}
