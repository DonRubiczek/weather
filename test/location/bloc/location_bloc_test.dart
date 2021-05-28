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

          when(
            () => weatherRepository.locationInformation(
              '1122221111222211',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
              false,
              null,
              400,
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
          expect(
            bloc.state,
            equals(
              Initial(),
            ),
          );
        },
      );

      group(
        'GetLocationData',
        () {
          blocTest(
            'yields location data collected state after'
            'correctly getting data',
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

          blocTest(
            'yields error state if no'
            'data with added id found',
            build: () => LocationBloc(
              weatherRepository,
            ),
            act: (LocationBloc bloc) => bloc.add(
              GetLocationData(
                locationId: '1122221111222211',
              ),
            ),
            verify: (LocationBloc b) => b.state == Error(),
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
    },
  );
}
