import 'package:flutter/material.dart';

class LoadingSpinnerComponent extends StatelessWidget {
  const LoadingSpinnerComponent({super.key, this.size = 100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
