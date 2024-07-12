import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  MediaQueryData get mediaQuery => MediaQueryData.fromView(
        View.of(this),
      );

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}
