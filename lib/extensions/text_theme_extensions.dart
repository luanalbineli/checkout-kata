import 'package:flutter/material.dart';

extension TextThemeExtensions on TextTheme {
  TextStyle? get screenTitle => titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      );
}
