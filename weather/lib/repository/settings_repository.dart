import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/utils/constants.dart';

class SettingsRepository {
  SettingsRepository(this.sharedPreferences) {
    themeId = sharedPreferences.getInt(
          CONSTANTS.SHARED_PREF_KEY_THEME,
        ) ??
        0;
    metricId = sharedPreferences.getInt(
          CONSTANTS.SHARED_PREF_KEY_UNIT_SYSTEM,
        ) ??
        0;
  }

  final SharedPreferences sharedPreferences;
  int? themeId;
  int? metricId;

  Future<bool> setThemeVariable(int id) async {
    var result = await sharedPreferences.setInt(
      CONSTANTS.SHARED_PREF_KEY_THEME,
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
      CONSTANTS.SHARED_PREF_KEY_UNIT_SYSTEM,
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
