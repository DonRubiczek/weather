import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/utils/constants.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late SettingsRepository settingsRepository;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    settingsRepository = SettingsRepository(
      sharedPreferences,
    );
  });

  group(
    'SettingsRepository',
    () {
      test(
        'can be instantiated',
        () {
          expect(
            SettingsRepository(
              sharedPreferences,
            ),
            isNotNull,
          );
        },
      );

      group(
        'Set theme',
        () {
          test(
            'theme id variable is set to 0'
            'if operation call succeeds',
            () async {
              await settingsRepository.setThemeVariable(0);
              expect(
                settingsRepository.themeId,
                0,
              );
              expect(
                settingsRepository.sharedPreferences.getInt(
                  CONSTANTS.SHARED_PREF_KEY_THEME,
                ),
                0,
              );
            },
          );

          test(
            'theme id variable is set to 1'
            'if operation call succeeds',
            () async {
              await settingsRepository.setThemeVariable(1);
              expect(settingsRepository.themeId, 1);
              expect(
                settingsRepository.sharedPreferences.getInt(
                  CONSTANTS.SHARED_PREF_KEY_THEME,
                ),
                1,
              );
            },
          );
        },
      );

      group(
        'Set metric system',
        () {
          test(
            'metric system id variable is set to 0 '
            'if operation call succeeds',
            () async {
              await settingsRepository.setMetricVariable(0);
              expect(
                settingsRepository.metricId,
                0,
              );
              expect(
                settingsRepository.sharedPreferences.getInt(
                  CONSTANTS.SHARED_PREF_KEY_UNIT_SYSTEM,
                ),
                0,
              );
            },
          );

          test(
            'metric system id variable is set to 1 '
            'if operation call succeeds',
            () async {
              await settingsRepository.setMetricVariable(1);
              expect(
                settingsRepository.metricId,
                1,
              );
              expect(
                settingsRepository.sharedPreferences.getInt(
                  CONSTANTS.SHARED_PREF_KEY_UNIT_SYSTEM,
                ),
                1,
              );
            },
          );
        },
      );
    },
  );
}
