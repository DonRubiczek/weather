import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/theme/app_theme.dart';

class BrightAppTheme extends AppTheme {
  static const Color snow = Color(0xFFFCFBFA);
  static const Color whiteSmoke = Color(0xFFF8F5F2);
  static const Color glitter = Color(0xFFDFF1F4);
  static const Color azure = Color(0xFF0091FD);
  static const Color sacramentoState = Color(0xFF005B4A);
  static const Color cadet = Color(0xFF525D66);
  static const Color coolGrey = Color(0xFF86939E);
  static const Color darkJungleGreen = Color(0xFF232323);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orangeyRed = Color(0xFFff5029);
  static const Color fadedJade = Color(0xFF427D72);
  static const Color aquaDeep = Color(0xFF005142);
  static const Color dark = Color(0xFF242931);
  static const Color paleTeal = Color(0XFFAAB3B1);

  static const Color mateoOrange = Color(0xFFFB7819);

  @override
  ThemeData get themeData => ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          primaryVariant: primaryColor,
          secondary: darkJungleGreen,
          secondaryVariant: darkJungleGreen,
          background: backgroundColor,
          surface: aquaDeep,
          onBackground: aquaDeep,
          onSurface: aquaDeep,
          onError: aquaDeep,
          onPrimary: aquaDeep,
          onSecondary: aquaDeep,
          error: errorColor,
        ),
      )
          .copyWith(
            iconTheme: IconThemeData(
              size: 24,
              color: primaryColor,
            ),
            snackBarTheme: SnackBarThemeData(
              contentTextStyle: headline1.copyWith(
                color: primaryColor,
              ),
              backgroundColor: errorColor,
            ),
            toggleableActiveColor: primaryColor,
            cursorColor: primaryColor,
            primaryColor: primaryColor,
            accentColor: primaryColor,
          )
          .copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: headline3.copyWith(
                color: primaryColor,
              ),
            ),
          );

  @override
  Color get headlineTextColor => darkJungleGreen;
  @override
  Color get bodyTextColor => darkJungleGreen;
  @override
  Color get primaryColor => mateoOrange;
  @override
  Color get secondaryColor => azure;
  @override
  Color get backgroundColor => whiteSmoke;
  @override
  Color get backgroundSecondaryColor => white;
  @override
  Color get errorColor => orangeyRed;
}

class DarkAppTheme extends AppTheme {
  static const Color snow = Color(0xFFFCFBFA);
  static const Color whiteSmoke = Color(0xFFF8F5F2);
  static const Color glitter = Color(0xFFDFF1F4);
  static const Color azure = Color(0xFF0091FD);
  static const Color sacramentoState = Color(0xFF005B4A);
  static const Color cadet = Color(0xFF525D66);
  static const Color coolGrey = Color(0xFF86939E);
  static const Color darkJungleGreen = Color(0xFF232323);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orangeyRed = Color(0xFFff5029);
  static const Color fadedJade = Color(0xFF427D72);
  static const Color aquaDeep = Color(0xFF005142);
  static const Color dark = Color(0xFF242931);
  static const Color paleTeal = Color(0XFFAAB3B1);
  static const Color mateoOrange = Color(0xFFFB7819);

  @override
  ThemeData get themeData => ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryColor,
          primaryVariant: primaryColor,
          secondary: darkJungleGreen,
          secondaryVariant: darkJungleGreen,
          background: backgroundColor,
          surface: backgroundColor,
          onBackground: white,
          onSurface: white,
          onError: white,
          onPrimary: white,
          onSecondary: white,
          error: errorColor,
        ),
      )
          .copyWith(
            iconTheme: IconThemeData(
              size: 24,
              color: primaryColor,
            ),
            snackBarTheme: SnackBarThemeData(
              contentTextStyle: headline1.copyWith(
                color: primaryColor,
              ),
              backgroundColor: errorColor,
            ),
            toggleableActiveColor: primaryColor,
            cursorColor: primaryColor,
            primaryColor: primaryColor,
            accentColor: primaryColor,
          )
          .copyWith(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: headline3.copyWith(
                color: primaryColor,
              ),
            ),
          );

  @override
  Color get headlineTextColor => white;
  @override
  Color get bodyTextColor => white;
  @override
  Color get primaryColor => mateoOrange;
  @override
  Color get secondaryColor => azure;
  @override
  Color get backgroundColor => dark;
  @override
  Color get errorColor => orangeyRed;
  @override
  Color get backgroundSecondaryColor => cadet;
}

extension ThemeExtension on BuildContext {
  AppTheme get theme => ThemeProvider.getThemeById(
        Provider.of<Backend>(this).settingsRepository.themeId,
      );
}

class ThemeProvider {
  static AppTheme getThemeById(int? id) {
    switch (id) {
      case 0:
        return BrightAppTheme();
      case 1:
        return DarkAppTheme();
      default:
        return BrightAppTheme();
    }
  }
}
