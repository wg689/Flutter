import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Hidefend {
  run(Widget app) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, (e, s) => _reportError(e, s));
  }

  _reportError(Object error, StackTrace s) {
    print("catch error: $error");
  }
}
