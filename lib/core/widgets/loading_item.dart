import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
