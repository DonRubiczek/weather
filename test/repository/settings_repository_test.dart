import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/utils/constants.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late SettingsRepository settingsRepository;

  setUp(
    () async {
      sharedPreferences = MockSharedPreferences();

      when(
        () => sharedPreferences.setInt(
          CONSTANTS.sharedPrefKeyTheme,
          0,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sharedPreferences.setInt(
          CONSTANTS.sharedPrefKeyTheme,
          1,
        ),
      ).thenAnswer(
        (_) async => false,
      );

      when(
        () => sharedPreferences.setInt(
          CONSTANTS.sharedPrefKeyUnitSystem,
          0,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sharedPreferences.setInt(
          CONSTANTS.sharedPrefKeyUnitSystem,
          1,
        ),
      ).thenAnswer(
        (_) async => false,
      );

      settingsRepository = SettingsRepository(
        sharedPreferences,
      );
    },
  );

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
            'theme id variable is set to 0 '
            'if operation call succeeds',
            () async {
              await settingsRepository.setThemeVariable(0);
              expect(
                settingsRepository.themeId,
                0,
              );
              verify(
                () => sharedPreferences.setInt(
                  CONSTANTS.sharedPrefKeyTheme,
                  0,
                ),
              ).called(1);
            },
          );

          test(
            'theme id variable is set to 0'
            'if operation call does not succeed',
            () async {
              await settingsRepository.setThemeVariable(1);
              expect(
                settingsRepository.themeId,
                0,
              );
              verify(
                () => sharedPreferences.setInt(
                  CONSTANTS.sharedPrefKeyTheme,
                  1,
                ),
              ).called(1);
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
              verify(
                () => sharedPreferences.setInt(
                  CONSTANTS.sharedPrefKeyUnitSystem,
                  0,
                ),
              ).called(1);
            },
          );

          test(
            'metric system id variable is set to 0 '
            'if operation call does not succeed',
            () async {
              await settingsRepository.setMetricVariable(1);
              expect(
                settingsRepository.metricId,
                0,
              );
              verify(
                () => sharedPreferences.setInt(
                  CONSTANTS.sharedPrefKeyUnitSystem,
                  1,
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}
