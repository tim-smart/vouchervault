import 'package:dartz/dartz.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen/screen.dart';

void useFullBrightness() => useEffect(() {
      Option<double> initialBrightness = none();
      Screen.brightness.then((b) {
        initialBrightness = some(b);
        Screen.setBrightness(1);
      });
      return () => initialBrightness.map(Screen.setBrightness);
    });
