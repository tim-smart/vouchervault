import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

SystemUiOverlayStyle useSystemOverlayStyle() {
  final context = useContext();
  final theme = Theme.of(context);

  final style = useMemoized(
    () => theme.brightness == Brightness.light
        ? SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: theme.colorScheme.background,
            systemNavigationBarIconBrightness: Brightness.dark,
          )
        : SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: theme.colorScheme.background,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
    [theme],
  );

  return style;
}
