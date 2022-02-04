import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

SystemUiOverlayStyle useSystemOverlayStyle() {
  final context = useContext();
  final theme = useMemoized(() => Theme.of(context), [context]);

  final style = useMemoized(
      () => theme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: theme.backgroundColor,
              systemNavigationBarIconBrightness: Brightness.dark,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: theme.backgroundColor,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
      [theme.brightness]);

  useEffect(() {
    SystemChrome.setSystemUIOverlayStyle(style);
    return null;
  }, [style]);

  return style;
}
