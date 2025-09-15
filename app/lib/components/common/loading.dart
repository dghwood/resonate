import 'package:flutter/material.dart';

class LoadingSpinnerComponent extends StatelessWidget {
  const LoadingSpinnerComponent({super.key, this.size = 100, this.value});

  final double size;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(child: CircularProgressIndicator(value: value)),
    );
  }
}
