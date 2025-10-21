import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static void error(Object error, StackTrace stacktrace) {
    if (kDebugMode) {
      print('ERROR: $error - $stacktrace');
    }
  }
}
