import 'package:flutter/material.dart' hide Action;
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:vouchervault/hooks/index.dart';

void useFullBrightness(
  RouteObserver<ModalRoute> routeObserver, {
  bool enabled = true,
}) {
  final brightness = useMemoized(() => ScreenBrightness());
  final goBright = useZIO(
    EIO
        .tryCatch(
          () => brightness.setScreenBrightness(1),
          (error, stackTrace) => 'Could not set brightness: $error',
        )
        .ignoreLogged,
    [brightness],
  );
  final goDark = useZIO(
    EIO
        .tryCatch(
          () => brightness.resetScreenBrightness(),
          (error, stackTrace) => 'Could not set brightness: $error',
        )
        .ignoreLogged,
    [brightness],
  );

  useEffect(() {
    if (enabled) {
      goBright();
    }

    return () {
      goDark();
    };
  }, [enabled]);

  // If something gets pushed on top of the route, then go dark again.
  useRouteObserver(
    routeObserver,
    didPushNext: some(() {
      goDark();
    }),
    didPopNext: some(() {
      if (!enabled) return;
      goBright();
    }),
    keys: [enabled],
  );
}
