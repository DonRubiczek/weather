import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/day_forecast/day_forecast_page.dart';
import 'package:weather/repository/model/location.dart';

import '../helpers/pump_app.dart';
import '../helpers/resources.dart';

class FakeDayForecastEvent extends Fake implements DayForecastEvent {}

class FakeDayForecastState extends Fake implements DayForecastState {}

class MockDayForecastBloc extends MockBloc<DayForecastEvent, DayForecastState>
    implements DayForecastBloc {}

extension on WidgetTester {
  Future<void>? pumpDayForecastView({
    required DayForecastBloc bloc,
    required Location location,
    required String date,
  }) {
    return pumpApp(
      BlocProvider.value(
        value: bloc,
        child: DayForecastView(
          location: location,
          date: date,
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue<DayForecastEvent>(
      FakeDayForecastEvent(),
    );
    registerFallbackValue<DayForecastState>(
      FakeDayForecastState(),
    );
  });

  group(
    'DayForecastView',
    () {
      late DayForecastBloc bloc;
      final location = Location(
        'London',
        'City',
        'lattLong',
        44418,
        123123,
      );
      final date = '2016/05/12';

      setUp(
        () {
          bloc = MockDayForecastBloc();
          whenListen(
            bloc,
            Stream.fromIterable(
              [
                DayForecastCollected(
                  getConsolidatedWeatherList(),
                ),
              ],
            ),
            initialState: DayForecastCollected(
              getConsolidatedWeatherList(),
            ),
          );
        },
      );

      testWidgets(
        'renders page',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byType(
              DayForecastView,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders app bar title',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.text(
              '${location.title} $date',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders elements on weather cards list',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              Key(
                'locationWeatherCardKey_'
                '${getConsolidatedWeatherList().first.id}',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders SKY header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherSkyHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders WIND header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherWindHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders TEMP header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherTempHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders HUMIDITY header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherHumidityHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders VISIBILITY header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherVisibilityHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      testWidgets(
        'renders AIR PRESSURE header on cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherAirPressureHeaderKey',
              ),
            ),
            findsWidgets,
          );
        },
      );

      // testWidgets(
      //   'renders last element of weather cards list id - 5139171757785088',
      //   (tester) async {
      //     await tester.pumpDayForecastView(
      //       bloc: bloc,
      //       location: location,
      //       date: date,
      //     );
      //     await tester.ensureVisible(
      //       find.byKey(
      //         const Key(
      //           'locationWeatherCardKey_5139171757785088',
      //         ),
      //         skipOffstage: false,
      //       ),
      //     );
      //   },
      // );

      testWidgets(
        'pops up view after clicking back button',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          await tester.tap(
            find.byKey(
              const Key(
                'dayForecastAppBarBackButton',
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.byType(
              DayForecastView,
            ),
            findsNothing,
          );
        },
      );
    },
  );
}
