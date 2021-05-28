import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/day_forecast/bloc/day_forecast_bloc.dart';
import 'package:weather/repository/model/consolidated_weather_list.dart';
import 'package:weather/repository/weather_repository.dart';

import '../../helpers/resources.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group(
    'DayForecastBloc',
    () {
      late WeatherRepository weatherRepository;

      setUp(
        () {
          weatherRepository = MockWeatherRepository();

          when(
            () => weatherRepository.locationDayInformation(
              '3344',
              '12/02/2020',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
              true,
              ConsolidatedWeatherList(
                getConsolidatedWeatherList(),
              ),
              200,
            ),
          );

          when(
            () => weatherRepository.locationDayInformation(
              '1122221111222211',
              '12/22/2020',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
              false,
              null,
              400,
            ),
          );

          when(
            () => weatherRepository.locationDayInformation(
              '1234',
              '12/22/2027',
            ),
          ).thenAnswer(
            (_) async => ApiResult(
              true,
              ConsolidatedWeatherList(
                [],
              ),
              200,
            ),
          );
        },
      );

      test(
        'can be instantiated',
        () {
          final bloc = DayForecastBloc(
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
          final bloc = DayForecastBloc(
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
        'GetLocationDayForecast',
        () {
          blocTest(
            'yields day forecast collected state with no empty list after'
            'correctly getting data from server',
            build: () => DayForecastBloc(
              weatherRepository,
            ),
            act: (DayForecastBloc bloc) => bloc.add(
              GetLocationDayForecast(
                locationId: '1234',
                date: '12/02/2020',
              ),
            ),
            verify: (DayForecastBloc b) =>
                b.state ==
                DayForecastCollected(
                  getConsolidatedWeatherList(),
                ),
          );

          blocTest(
            'yields day forecast collected state with empty list after'
            'correctly getting data from server but not finding on it forecast'
            'for added searching criteria - location and day',
            build: () => DayForecastBloc(
              weatherRepository,
            ),
            act: (DayForecastBloc bloc) => bloc.add(
              GetLocationDayForecast(
                locationId: '1234',
                date: '12/22/2027',
              ),
            ),
            verify: (DayForecastBloc b) =>
                b.state ==
                DayForecastCollected(
                  [],
                ),
          );

          blocTest(
            'yields error state if no'
            'location with added id found on server',
            build: () => DayForecastBloc(
              weatherRepository,
            ),
            act: (DayForecastBloc bloc) => bloc.add(
              GetLocationDayForecast(
                locationId: '1122221111222211',
                date: '12/22/2020',
              ),
            ),
            verify: (DayForecastBloc b) => b.state == Error(),
          );

          blocTest<DayForecastBloc, DayForecastState>(
            'keeps previous state if repository throws error',
            build: () {
              when(
                () => weatherRepository.locationDayInformation(
                  '1234',
                  '12/22/2020',
                ),
              ).thenThrow(
                Exception(),
              );
              return DayForecastBloc(
                weatherRepository,
              );
            },
            seed: () => Loading(),
            act: (b) => b.add(
              GetLocationDayForecast(
                locationId: '1234',
                date: '12/22/2020',
              ),
            ),
            verify: (DayForecastBloc b) => b.state == Initial(),
          );
        },
      );
    },
  );
}
