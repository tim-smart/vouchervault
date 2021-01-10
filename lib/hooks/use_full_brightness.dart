import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen/screen.dart';

Future<double> _getBrightness() =>
    Platform.isAndroid ? Future.value(-1) : Screen.brightness;

void useFullBrightness({bool enabled = true}) => useEffect(() {
      if (!enabled) return () {};

      final future = _getBrightness().then((b) {
        Screen.setBrightness(1);
        return b;
      });
      return () => future.then((b) => Screen.setBrightness(b));
    });
