import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group(
    'SettingsBloc',
    () {
      late SettingsRepository settingsRepository;

      setUp(
        () {
          settingsRepository = MockSettingsRepository();
        },
      );

      test('can be instantiated', () {
        final bloc = SettingsBloc(settingsRepository: settingsRepository);
        expect(bloc, isNotNull);
      });

      test(
        'initial state is SettingsState Initial',
        () {
          final bloc = SettingsBloc(settingsRepository: settingsRepository);
          expect(
            bloc.state,
            equals(
              Initial(),
            ),
          );
        },
      );

      group(
        'ChangeTheme',
        () {
          blocTest(
            'yields app settings changed state after changing theme',
            build: () => SettingsBloc(settingsRepository: settingsRepository),
            act: (SettingsBloc bloc) => bloc.add(
              ChangeTheme(themeId: 0),
            ),
            verify: (SettingsBloc b) => b.state == AppSettingsChanged(),
          );

          blocTest<SettingsBloc, SettingsState>(
            'keeps previous state if repository throws error',
            build: () {
              when(() => settingsRepository.setThemeVariable(0)).thenThrow(
                Exception(),
              );
              return SettingsBloc(settingsRepository: settingsRepository);
            },
            seed: () => AppSettingsChanged(),
            act: (b) => b.add(
              ChangeTheme(themeId: 0),
            ),
            verify: (SettingsBloc b) => b.state == Initial(),
          );
        },
      );

      group(
        'Change metric system',
        () {
          blocTest(
            'yields app settings changed state after changing metric system',
            build: () => SettingsBloc(settingsRepository: settingsRepository),
            act: (SettingsBloc bloc) => bloc.add(
              ChangeMetricSystem(systemId: 0),
            ),
            verify: (SettingsBloc b) => b.state == AppSettingsChanged(),
          );
        },
      );
    },
  );
}
