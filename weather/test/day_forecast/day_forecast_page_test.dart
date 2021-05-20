import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/day_forecast/day_forecast_page.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';

import '../helpers/pump_app.dart';

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
                  _getConsolidatedWeatherList(),
                ),
              ],
            ),
            initialState: DayForecastCollected(
              _getConsolidatedWeatherList(),
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
        'renders all weather cards',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherCardKey',
              ),
            ),
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - SKY',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - WIND',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - TEMP',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - HUMIDITY',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - VISIBILITY',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - AIR PRESSURE',
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
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

      testWidgets(
        'renders all weather headers - PREDICTABILITY',
        (tester) async {
          await tester.pumpDayForecastView(
            bloc: bloc,
            location: location,
            date: date,
          );
          expect(
            find.byKey(
              const Key(
                'locationWeatherPredictHeaderKey',
              ),
            ),
            findsNWidgets(
              _getConsolidatedWeatherList().length,
            ),
          );
        },
      );

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

List<ConsolidatedWeather> _getConsolidatedWeatherList() {
  return [
    ConsolidatedWeather(
      6458195808616448,
      'Light Rain',
      'lr',
      'ESE',
      '2021-05-13T15,32,02.331662Z',
      '2021-05-13',
      8.215,
      13.395,
      11.71,
      4.724408115034863,
      106.1685937400188,
      1006.0,
      84,
      8.81694653225165,
      75,
    ),
    ConsolidatedWeather(
      6128491704614912,
      'Light Rain',
      'lr',
      'NNE',
      '2021-05-13T15,32,02.746506Z',
      '2021-05-14',
      7.130000000000001,
      15.455,
      13.28,
      4.313319697598028,
      30.29213361107689,
      1009.5,
      69,
      11.40154000636284,
      75,
    ),
    ConsolidatedWeather(
      5590954569367552,
      'Light Rain',
      'lr',
      'SSW',
      '2021-05-13T15,32,03.152174Z',
      '2021-05-15',
      8.265,
      13.6,
      12.3,
      5.34320908801665,
      210.91901171401153,
      1001.0,
      79,
      11.046115684403086,
      75,
    ),
    // ConsolidatedWeather(
    //     6181386139467776,
    //     "Light Rain",
    //     "lr",
    //     "SW",
    //     "2021-05-13T15,32,02.491613Z",
    //     "2021-05-16",
    //     7.48,
    //     14.030000000000001,
    //     14.075,
    //     8.17269706152337,
    //     223.6666365779404,
    //     999.0,
    //     75,
    //     8.426104052334367,
    //     75),
    // ConsolidatedWeather(
    //     5139171757785088,
    //     "Light Rain",
    //     "lr",
    //     "W",
    //     "2021-05-13T15,32,02.952686Z",
    //     "2021-05-17",
    //     8.955,
    //     14.21,
    //     14.245000000000001,
    //     7.908148727543147,
    //     268.6677210568365,
    //     1002.5,
    //     76,
    //     11.81413047800843,
    //     75)
  ];
}
