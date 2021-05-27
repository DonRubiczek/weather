import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/utils/constants.dart';

class SettingsRepository {
  SettingsRepository(this.sharedPreferences) {
    themeId = sharedPreferences.getInt(
          CONSTANTS.sharedPrefKeyTheme,
        ) ??
        0;
    metricId = sharedPreferences.getInt(
          CONSTANTS.sharedPrefKeyUnitSystem,
        ) ??
        0;
  }

  final SharedPreferences sharedPreferences;
  int? themeId;
  int? metricId;

  Future<bool> setThemeVariable(int id) async {
    var result = await sharedPreferences.setInt(
      CONSTANTS.sharedPrefKeyTheme,
      id,
    );

    if (result) {
      themeId = id;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setMetricVariable(int id) async {
    var result = await sharedPreferences.setInt(
      CONSTANTS.sharedPrefKeyUnitSystem,
      id,
    );
    if (result) {
      metricId = id;
      return true;
    } else {
      return false;
    }
  }
}
