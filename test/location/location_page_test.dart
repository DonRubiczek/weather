import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/location/bloc/location_bloc.dart';
import 'package:weather/location/location_page.dart';
import 'package:weather/repository/model/location.dart';

import '../helpers/pump_app.dart';
import '../helpers/resources.dart';

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
                  getLocationData(),
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
        'Renders headers filled with location data',
        () {
          testWidgets(
            'renders all page headers',
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
                  'location type: ${getLocationData().locationType}',
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
                  'lattitude: ${getLocationData().lattlong.split(',').first}',
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
                  'longitude: ${getLocationData().lattlong.split(',').last}',
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
                  'timezone: ${getLocationData().timezone}'
                  '-${getLocationData().timezoneName}',
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
                  'time: ${getLocationData().time}',
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
                  'sun rise: ${getLocationData().sunRise}',
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
                  'sun set: ${getLocationData().sunSet}',
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
                  'Choose date from the past and display location weather:',
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
            'renders weather cards',
            (tester) async {
              var data = getLocationData().consolidatedWeatherData;
              await tester.pumpLocationPage(
                bloc: bloc,
                location: location,
              );
              expect(
                find.byKey(
                  Key(
                    'locationWeatherCardKey_'
                    '${data.first.id.toString()}',
                  ),
                ),
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - SKY',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - WIND',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - TEMP',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - HUMIDITY',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - VISIBILITY',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards headers - AIR PRESSURE',
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
                findsWidgets,
              );
            },
          );

          testWidgets(
            'renders weather cards header - PREDICTABILITY',
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
                findsWidgets,
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
            'renders elements in sources section',
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
                findsWidgets,
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
