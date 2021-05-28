import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_list.dart';
import 'package:weather/repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group(
    'HomeBloc',
    () {
      late WeatherRepository weatherRepository;

      setUp(
        () {
          weatherRepository = MockWeatherRepository();

          when(
            () => weatherRepository.locationSearchByName(
              'BlablaBlablaBlablaBlablaBlablaBlabla',
            ),
          ).thenAnswer(
            (_) async {
              return ApiResult(
                true,
                LocationList(
                  [],
                ),
                200,
              );
            },
          );

          when(
            () => weatherRepository.locationSearchByName(
              'London',
            ),
          ).thenAnswer(
            (_) async {
              return ApiResult(
                true,
                LocationList(
                  [
                    Location(
                      'London',
                      'locationType1',
                      'lattLong1',
                      1,
                      1,
                    ),
                  ],
                ),
                200,
              );
            },
          );

          when(
            () => weatherRepository.locationSearchByCoordinates(
              '12',
              '22',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
                true,
                LocationList(
                  [
                    Location(
                      'London',
                      'City',
                      '51.506321,-0.12714',
                      44418,
                      null,
                    )
                  ],
                ),
                200),
          );
        },
      );

      test('can be instantiated', () {
        final bloc = HomeBloc(
          weatherRepository,
        );
        expect(
          bloc,
          isNotNull,
        );
      });

      test(
        'initial state is SettingsState Initial',
        () {
          final bloc = HomeBloc(
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
        'Search location by name',
        () {
          blocTest(
            'yields locations collected with empty locations list if'
            ' no locations match added searching name',
            build: () => HomeBloc(weatherRepository),
            act: (HomeBloc bloc) => bloc.add(
              FindLocationByNameEvent(
                locationName: 'BlablaBlablaBlablaBlablaBlablaBlabla',
              ),
            ),
            verify: (HomeBloc b) => b.state == LocationsCollected([]),
          );

          blocTest(
            'yields locations collected with not empty locations list if'
            ' any locations match added searching name',
            build: () => HomeBloc(weatherRepository),
            act: (HomeBloc bloc) => bloc.add(
              FindLocationByNameEvent(
                locationName: 'London',
              ),
            ),
            verify: (HomeBloc b) =>
                b.state ==
                LocationsCollected(
                  [
                    Location(
                      'London',
                      'locationType1',
                      'lattLong1',
                      1,
                      1,
                    ),
                  ],
                ),
          );

          blocTest<HomeBloc, HomeState>(
            'keeps previous state if repository throws error',
            build: () {
              when(
                () => weatherRepository.locationSearchByName(''),
              ).thenThrow(
                Exception(),
              );
              return HomeBloc(
                weatherRepository,
              );
            },
            seed: () => LocationsCollected([]),
            act: (b) => b.add(
              FindLocationByNameEvent(locationName: ''),
            ),
            verify: (HomeBloc b) => b.state == Initial(),
          );
        },
      );

      group(
        'Change location by coordinates',
        () {
          blocTest<HomeBloc, HomeState>(
            'yields locations collected with locations list'
            ' containing 1 nearest lostaion to added coordinates',
            build: () {
              return HomeBloc(weatherRepository);
            },
            act: (HomeBloc bloc) => bloc.add(
              FindLocationByCoordinatesEvent(
                lattitude: '12',
                longitude: '22',
              ),
            ),
            verify: (HomeBloc b) =>
                b.state ==
                LocationsCollected(
                  [
                    Location(
                      'London',
                      'City',
                      '51.506321,-0.12714',
                      44418,
                      null,
                    )
                  ],
                ),
          );
        },
      );
    },
  );
}
