import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/settings/settings_page.dart';

import '../helpers/pump_app.dart';

class FakeSettingsEvent extends Fake implements SettingsEvent {}

class FakeSettingsState extends Fake implements SettingsState {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

extension on WidgetTester {
  Future<void>? pumpSettingsPage({
    required SettingsBloc bloc,
  }) {
    return pumpApp(
      BlocProvider.value(
        value: bloc,
        child: SettingsView(),
      ),
      settingsRepository: MockSettingsRepository(),
    );
  }
}

void main() {
  setUpAll(
    () {
      registerFallbackValue<SettingsEvent>(
        FakeSettingsEvent(),
      );
      registerFallbackValue<SettingsState>(
        FakeSettingsState(),
      );
    },
  );

  group(
    'SettingsView',
    () {
      late SettingsBloc bloc;

      setUp(
        () {
          bloc = MockSettingsBloc();
          whenListen(
            bloc,
            Stream.fromIterable(
              [
                Initial(),
                AppSettingsChanged(),
              ],
            ),
            initialState: Initial(),
          );
        },
      );

      test(
        'is routable',
        () {
          expect(
            SettingsPage.route(),
            isA<MaterialPageRoute>(),
          );
        },
      );

      testWidgets(
        'renders page',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.byType(
              SettingsView,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders settings app bar',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.text(
              'Settings',
            ),
            findsOneWidget,
          );
          expect(
            find.byIcon(
              Icons.arrow_back,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders theme header',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.text(
              'Theme',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders light theme option',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.byKey(
              const Key(
                'settingsLightThemeOption',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders dark theme option',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.byKey(
              const Key(
                'settingsDarkThemeOption',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders unit system header',
        (tester) async {
          await tester.pumpSettingsPage(
            bloc: bloc,
          );
          expect(
            find.text(
              'Unit system',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders metric system option',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          expect(
            find.byKey(
              const Key(
                'settingsMetricSystemOption',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders dark theme option',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          expect(
            find.byKey(
              const Key(
                'settingsImperialSystemOption',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'pops up view after clicking back button',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          await tester.tap(
            find.byKey(
              const Key(
                'settingsAppBarBackButton',
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.byType(
              SettingsView,
            ),
            findsNothing,
          );
        },
      );
    },
  );
}
