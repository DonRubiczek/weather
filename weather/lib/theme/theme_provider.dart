import 'package:flutter/cupertino.dart';
import 'package:weather/theme/app_theme.dart';
import 'package:weather/theme/app_specific_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme theme = BrightAppTheme();
  void update(int? themeId) {
    final newTheme = getThemeById(themeId);

    if (theme.runtimeType != newTheme.runtimeType) {
      theme = newTheme;
      notifyListeners();
    }
  }

  AppTheme getThemeById(int? id) {
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
