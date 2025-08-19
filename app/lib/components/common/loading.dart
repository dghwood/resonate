import 'package:flutter/material.dart';

class LoadingSpinnerComponent extends StatelessWidget {
  const LoadingSpinnerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
