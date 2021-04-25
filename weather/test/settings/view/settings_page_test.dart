import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/home/home_page.dart';
import 'package:weather/settings/bloc/settings_bloc.dart';
import 'package:weather/settings/settings_page.dart';

import '../../helpers/pump_app.dart';

class FakeSettingsEvent extends Fake implements SettingsEvent {}

class FakeSettingsState extends Fake implements SettingsState {}

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

extension on WidgetTester {
  Future<void>? pumpSettingsPage({
    required SettingsBloc bloc,
  }) {
    // return pumpApp(
    //   BlocProvider.value(
    //     value: bloc,
    //     child: const SettingsPage(),
    //   ),
    // );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue<SettingsEvent>(FakeSettingsEvent());
    registerFallbackValue<SettingsState>(FakeSettingsState());
  });

  group(
    'SettingsPage',
    () {
      late SettingsBloc bloc;

      setUp(() {
        bloc = MockSettingsBloc();
        whenListen(
          bloc,
          Stream.fromIterable([Initial()]),
          initialState: Initial(),
        );
      });

      test('is routable', () {
        expect(SettingsPage.route(), isA<MaterialPageRoute>());
      });

      testWidgets('renders page', (tester) async {
        await tester.pumpSettingsPage(bloc: bloc);
        expect(find.byType(SettingsPage), findsOneWidget);
      });

      testWidgets(
        'renders settings app bar',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          expect(
            find.text('Settings'),
            findsOneWidget,
          );
          expect(
            find.byIcon(Icons.arrow_back),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders theme header',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          expect(
            find.text('Theme'),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders unit system header',
        (tester) async {
          await tester.pumpSettingsPage(bloc: bloc);
          expect(
            find.text('Unit system'),
            findsOneWidget,
          );
        },
      );

      testWidgets('navigates to home page after clicks on back button',
          (tester) async {
        await tester.pumpSettingsPage(bloc: bloc);
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });

      // testWidgets(
      //     'does not navigate to edit contact page '
      //     'after clicks on profile tile when contact is null', (tester) async {
      //   whenListen(
      //     bloc,
      //     Stream.fromIterable([AppSettingsChanged]),
      //     initialState: AppSettingsChanged,
      //   );
      //   await tester.pumpSettingsPage(bloc: bloc);
      //   await tester.tap(
      //     find.byKey(Key('careGiverSettinsPage_listTile_profile')),
      //   );
      //   await tester.pumpAndSettle();
      //   expect(find.byType(AppSettingsChanged), findsNothing);
      // });
    },
  );
}
