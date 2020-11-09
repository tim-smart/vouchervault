import 'package:dartz/dartz.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen/screen.dart';

void useFullBrightness({bool enabled = true}) => useEffect(() {
      if (!enabled) return () {};

      var initialBrightness = none<double>();
      Screen.brightness.then((b) {
        initialBrightness = some(b);
        Screen.setBrightness(1);
      });
      return () => initialBrightness.map(Screen.setBrightness);
    });
