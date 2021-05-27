import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/location/bloc/location_bloc.dart';
import 'package:weather/repository/weather_repository.dart';

import '../../helpers/resources.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group(
    'LocationBloc',
    () {
      late WeatherRepository weatherRepository;

      setUp(
        () {
          weatherRepository = MockWeatherRepository();

          when(
            () => weatherRepository.locationInformation(
              '3344',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
              true,
              getLocationData(),
              200,
            ),
          );
        },
      );

      test(
        'can be instantiated',
        () {
          final bloc = LocationBloc(
            weatherRepository,
          );
          expect(
            bloc,
            isNotNull,
          );
        },
      );

      test(
        'initial state is SettingsState Initial',
        () {
          final bloc = LocationBloc(
            weatherRepository,
          );
          verify(
            () => bloc.state == Initial(),
          );
        },
      );

      group(
        'GetLocationData',
        () {
          blocTest(
            'yields location data collected state after getting data',
            build: () => LocationBloc(
              weatherRepository,
            ),
            act: (LocationBloc bloc) => bloc.add(
              GetLocationData(
                locationId: '1234',
              ),
            ),
            verify: (LocationBloc b) =>
                b.state ==
                LocationDataCollected(
                  getLocationData(),
                ),
          );

          blocTest<LocationBloc, LocationState>(
            'keeps previous state if repository throws error',
            build: () {
              when(
                () => weatherRepository.locationInformation(
                  '1234',
                ),
              ).thenThrow(
                Exception(),
              );
              return LocationBloc(
                weatherRepository,
              );
            },
            seed: () => Loading(),
            act: (b) => b.add(
              GetLocationData(
                locationId: '1234',
              ),
            ),
            verify: (LocationBloc b) => b.state == Initial(),
          );
        },
      );

      group(
        'NavigateToLocationForecast',
        () {
          blocTest(
            'yields location data collected state after getting data',
            build: () => LocationBloc(
              weatherRepository,
            ),
            act: (LocationBloc bloc) => bloc.add(
              NavigateToLocationForecast(
                date: '22/06/2018/',
              ),
            ),
            verify: (LocationBloc b) =>
                b.state ==
                Navigate(
                  '22/06/2018/',
                ),
          );
        },
      );
    },
  );
}
