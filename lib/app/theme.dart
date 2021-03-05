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

  static ThemeData build() {
    var textTheme = ThemeData(fontFamily: 'Alegreya Sans').textTheme;
    textTheme = textTheme.copyWith(
      headline2: textTheme.headline2.copyWith(
        color: Colors.black,
        fontSize: px(34),
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w900,
      ),
      headline3: textTheme.headline3.copyWith(
        color: Colors.black,
        fontSize: px(20),
        fontWeight: FontWeight.w700,
      ),
      bodyText1: textTheme.bodyText1.copyWith(
        color: Colors.black,
        fontSize: rem(1),
        fontWeight: FontWeight.w400,
      ),
      bodyText2: textTheme.bodyText2.copyWith(
        color: Colors.black,
        fontSize: rem(1),
        fontWeight: FontWeight.w800,
      ),
      button: textTheme.button.copyWith(
        fontSize: px(20),
        fontWeight: FontWeight.w900,
      ),
    );

    return ThemeData(
      fontFamily: 'Alegreya Sans',
      textTheme: textTheme,
      primaryColor: Colors.red,
      accentColor: Colors.red[800],
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.red,
        accentColor: Colors.red[800],
        backgroundColor: AppColors.background,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(0, rem(2.5)),
          primary: Colors.red,
          onPrimary: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        centerTitle: false,
        color: AppColors.background,
        textTheme: textTheme,
        iconTheme: IconThemeData(
          color: textTheme.bodyText1.color,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
