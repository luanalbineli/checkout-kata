import 'package:checkout/constants/app_colors.dart';
import 'package:checkout/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static ThemeData getTheme(BuildContext context) {
    final baseTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: context.theme.colorScheme.inversePrimary,
      ),
    );
  }
}
