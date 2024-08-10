import 'package:flutter/material.dart';

class AppTheme {
  static const baseFontSize = 18;
  static double rem(double rem) => baseFontSize * rem;
  static double px(double px) => rem(px / 18);

  static double get space1 => rem(0.1);
  static double get space2 => rem(0.3);
  static double get space3 => rem(0.6);
  static double get space4 => rem(1);
  static double get space5 => rem(1.5);
  static double get space6 => rem(2.5);
  static double get space7 => rem(4);

  static ThemeData build(ColorScheme scheme) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: scheme,
    ).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
    );
  }
}
