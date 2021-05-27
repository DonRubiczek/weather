import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/api/entity_factory.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:weather/home/home_page.dart';
import 'package:weather/location/location_page.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/settings_repository.dart';
import 'package:weather/repository/weather_repository.dart';
import 'package:weather/settings/settings_page.dart';

import '../helpers/pump_app.dart';

class FakeHomeEvent extends Fake implements HomeEvent {}

class FakeHomeState extends Fake implements HomeState {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

extension on WidgetTester {
  Future<void>? pumpHomePage({
    required HomeBloc bloc,
    required WeatherRepository weatherRepository,
    SettingsRepository? settingsRepository,
  }) {
    return pumpApp(
      BlocProvider.value(
        value: bloc,
        child: HomeView(),
      ),
      weatherRepository: weatherRepository,
      settingsRepository: settingsRepository,
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue<HomeEvent>(
      FakeHomeEvent(),
    );
    registerFallbackValue<HomeState>(
      FakeHomeState(),
    );
  });

  group(
    'HomeView',
    () {
      late HomeBloc bloc;
      late WeatherRepository weatherRepository;
      late SettingsRepository settingsRepository;
      late List<Location> locations;

      setUp(
        () {
          bloc = MockHomeBloc();
          weatherRepository = MockWeatherRepository();
          settingsRepository = MockSettingsRepository();

          locations = List<Location>.of(
            {
              Location(
                'San Marino',
                'City',
                'lattLong',
                44418,
                123123,
              ),
            },
          );

          whenListen(
            bloc,
            Stream.fromIterable(
              [
                LocationsCollected(
                  locations,
                )
              ],
            ),
            initialState: LocationsCollected(
              locations,
            ),
          );

          when(
            () => settingsRepository.metricId,
          ).thenAnswer(
            (_) {
              return 0;
            },
          );

          when(
            () => weatherRepository.locationInformation(
              locations.first.woeid.toString(),
            ),
          ).thenAnswer(
            (_) async {
              var jsonText = await rootBundle.loadString(
                'assets/location.json',
              );
              var jsonData = jsonDecode(
                jsonText,
              );
              var location = EntityFactory.generateOBJ<LocationData>(
                jsonData,
              );
              return ApiResult(
                true,
                location,
                200,
              );
            },
          );
        },
      );

      test(
        'is routable',
        () {
          expect(
            HomePage.route(),
            isA<MaterialPageRoute>(),
          );
        },
      );

      testWidgets(
        'renders page',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.byType(
              HomeView,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders home app bar',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.text(
              'Weather',
            ),
            findsOneWidget,
          );
          expect(
            find.byIcon(
              Icons.settings,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders search location by name header',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.text(
              'Search location by name',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders search location by name field',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.byKey(
              const Key(
                'searchLocationByNameField',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders search location by coordinates header',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.text(
              'Search location by coordinates',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders search location by coordinates - lattitude field',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.byKey(
              const Key(
                'searchLocationByCoordinatesLattitudeField',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders search location by coordinates - longitude field',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.byKey(
              const Key(
                'searchLocationByCoordinatesLongitudeField',
              ),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'renders San Marino list tile',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          expect(
            find.text(
              'San Marino',
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'navigates to settings view after clicking settings button',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
            settingsRepository: settingsRepository,
          );
          await tester.tap(
            find.byKey(
              const Key(
                'homeAppBarSettingsButton',
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.byType(
              SettingsView,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'navigates to location view after clicking location tile',
        (tester) async {
          await tester.pumpHomePage(
            bloc: bloc,
            weatherRepository: weatherRepository,
          );
          await tester.tap(
            find.byKey(
              const Key(
                'locationListTile',
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(
            find.byType(
              LocationView,
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}
