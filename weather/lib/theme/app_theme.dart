import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get themeData;

  // Colors
  Color get backgroundColor;
  Color get headlineTextColor;
  Color get bodyTextColor;
  Color get secondaryColor;
  Color get errorColor;
  Color get primaryColor;
  Color get backgroundSecondaryColor;

  // Typography
  TextStyle get headline0 => TextStyle(
        fontSize: 20,
        color: headlineTextColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headline1 => TextStyle(
        fontSize: 15,
        color: headlineTextColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headline2 => TextStyle(
        fontSize: 13,
        color: headlineTextColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get headline3 => TextStyle(
        fontSize: 18,
        color: headlineTextColor,
        fontWeight: FontWeight.w600,
      );

  EdgeInsets get horizontalPadding16 =>
      const EdgeInsets.symmetric(horizontal: 16.0);
}
