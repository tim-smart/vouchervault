import 'package:flutter/material.dart';
import 'package:vouchervault/app/app.dart';

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

  static ThemeData _build({
    required Brightness brightness,
    required Color backgroundColor,
    required Color textColor,
    required Color accentColor,
  }) {
    var textTheme = ThemeData(
      brightness: brightness,
      fontFamily: 'Alegreya Sans',
    ).textTheme;

    textTheme = textTheme.copyWith(
      displayMedium: textTheme.displayMedium!.copyWith(
        color: textColor,
        fontSize: px(34),
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w900,
      ),
      displaySmall: textTheme.displaySmall!.copyWith(
        color: textColor,
        fontSize: px(20),
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: textTheme.bodyLarge!.copyWith(
        color: textColor,
        fontSize: rem(1),
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: textTheme.bodyMedium!.copyWith(
        color: textColor,
        fontSize: rem(1),
        fontWeight: FontWeight.w800,
      ),
      labelLarge: textTheme.labelLarge!.copyWith(
        fontSize: px(20),
        fontWeight: FontWeight.w900,
      ),
    );

    return ThemeData.from(
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSwatch(
        brightness: brightness,
        primarySwatch: Colors.red,
        primaryColorDark: Colors.red.shade800,
        accentColor: Colors.red,
        backgroundColor: backgroundColor,
        errorColor: Colors.orange.shade700,
      ),
    ).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      chipTheme: ChipThemeData.fromDefaults(
        brightness: brightness,
        secondaryColor: Colors.red,
        labelStyle: textTheme.bodyMedium!.copyWith(fontSize: rem(0.8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, rem(2.5)),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        color: backgroundColor,
        iconTheme: IconThemeData(
          color: textTheme.bodyLarge!.color,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      toggleableActiveColor: Colors.red,
    );
  }

  static ThemeData light() => _build(
        brightness: Brightness.light,
        backgroundColor: AppColors.background,
        accentColor: Colors.red.shade800,
        textColor: Colors.black,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        backgroundColor: Colors.grey.shade900,
        accentColor: Colors.red,
        textColor: Colors.white,
      );
}
