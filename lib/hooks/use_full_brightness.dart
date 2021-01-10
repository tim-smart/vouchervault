import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen/screen.dart';

void useFullBrightness({bool enabled = true}) => useEffect(() {
      if (!enabled) return () {};
      final future = Screen.setBrightness(1);
      return () => future.then((_) => Screen.setBrightness(-1));
    });
