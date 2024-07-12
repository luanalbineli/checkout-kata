import 'package:flutter/material.dart';

class FullWidth extends StatelessWidget {
  final Widget child;

  const FullWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: child,
    );
  }
}
