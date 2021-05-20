import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/location/bloc/location_bloc.dart';
import 'package:weather/location/location_page.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/parent.dart';
import 'package:weather/repository/model/sources.dart';

import '../helpers/pump_app.dart';

class FakeLocationEvent extends Fake implements LocationEvent {}

class FakeLocationState extends Fake implements LocationState {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

extension on WidgetTester {
  Future<void>? pumpLocationPage({
    required LocationBloc bloc,
    required Location location,
  }) {
    return pumpApp(
      BlocProvider.value(
        value: bloc,
        child: LocationView(
          location: location,
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue<LocationEvent>(
      FakeLocationEvent(),
    );
    registerFallbackValue<LocationState>(
      FakeLocationState(),
    );
  });

  group(
    'LocationView',
    () {
      late LocationBloc bloc;
      late Location location;

      setUp(
        () {
          bloc = MockLocationBloc();
          location = Location(
            'London',
            'City',
            'lattLong',
            44418,
            123123,
          );

          whenListen(
            bloc,
            Stream.fromIterable(
              [
                LocationDataCollected(
                  _getLocationData(),
                ),
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
            LocationPage.route(
              location: location,
            ),
            isA<MaterialPageRoute>(),
          );
        },
      );

      testWidgets(
        'renders page',
        (tester) async {
          await tester.pumpLocationPage(
            bloc: bloc,
            location: location,
          );
          expect(
            find.byType(
              LocationView,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders page appbar with location title',
        (tester) async {
          await tester.pumpLocationPage(
            bloc: bloc,
            location: location,
          );
          expect(
            find.text(
              'London',
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

      group(
        'Renders location data headers',
        () {
          testWidgets(
            'renders location headers',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationHeaderKey',
                  ),
                ),
                findsNWidgets(
                  7,
                ),
              );
            },
          );

          testWidgets(
            'renders location type header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'location type: ${_getLocationData().locationType}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders lattitude header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'lattitude: ${_getLocationData().lattlong.split(',').first}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders longitude header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'longitude: ${_getLocationData().lattlong.split(',').last}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders timezone header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'timezone: ${_getLocationData().timezone}'
                  '-${_getLocationData().timezoneName}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders time header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'time: ${_getLocationData().time}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders sunrise header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'sun rise: ${_getLocationData().sunRise}',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders sun set header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'sun set: ${_getLocationData().sunSet}',
                ),
                findsOneWidget,
              );
            },
          );
        },
      );

      group(
        'Renders select date field',
        () {
          testWidgets(
            'renders select date field header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'Display weather for location by date:',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders select date field button',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationSelectDateButtonKey',
                  ),
                ),
                findsOneWidget,
              );
            },
          );
        },
      );

      group(
        'Renders location weather cards with data',
        () {
          testWidgets(
            'renders all location weather cards',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherCardKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - SKY',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherSkyHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - WIND',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherWindHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - TEMP',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherTempHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - HUMIDITY',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherHumidityHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - VISIBILITY',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherVisibilityHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - AIR PRESSURE',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherAirPressureHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );

          testWidgets(
            'renders all weather headers - PREDICTABILITY',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationWeatherPredictHeaderKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().consolidatedWeatherData.length,
                ),
              );
            },
          );
        },
      );

      group(
        'Renders sources section',
        () {
          testWidgets(
            'renders sources section header',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.text(
                  'Sources',
                ),
                findsOneWidget,
              );
            },
          );

          testWidgets(
            'renders all sources',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  const Key(
                    'locationSourceTileKey',
                  ),
                ),
                findsNWidgets(
                  _getLocationData().sources.length,
                ),
              );
            },
          );

          testWidgets(
            'pops up view after clicking back button',
            (tester) async {
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              await tester.tap(
                find.byKey(
                  const Key(
                    'locationAppBarBackButton',
                  ),
                ),
              );
              await tester.pumpAndSettle();
              expect(
                find.byType(
                  LocationView,
                ),
                findsNothing,
              );
            },
          );
        },
      );
    },
  );
}

LocationData _getLocationData() {
  var sources = <Sources>[
    //Sources("BBC", "http,//www.bbc.co.uk/weather/"),
    //Sources("Forecast.io", "http,//forecast.io/"),
    Sources(
      'Weather Underground',
      'https,//www.wunderground.com/?apiref=fc30dc3cd224e19b',
    ),
    //Sources("World Weather Online", "http,//www.worldweatheronline.com/"),
    Sources(
      'OpenWeatherMap',
      'http,//openweathermap.org/',
    ),
    Sources(
      'HAMweather',
      'http,//www.hamweather.com',
    ),
    Sources(
      'Met Office',
      'http,//www.metoffice.gov.uk/',
    ),
  ];
  var parent = Parent(
    'England',
    'Region / State / Province',
    '52.883560,-1.974060',
    24554868,
  );

  var consolidatedWeatherList = [
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

  return LocationData(
    consolidatedWeatherList,
    '2021-05-13T19,12,24.118975+01,00',
    '2021-05-13T05,11,30.918760+01,00',
    '2021-05-13T20,43,11.255541+01,00',
    'LMT',
    parent,
    sources,
    'London',
    'City',
    44418,
    '51.506321,-0.12714',
    'Europe/London',
  );
}
