import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/api/api_client.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/repository/model/consolidated_weather_list.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/location_list.dart';
import 'package:weather/repository/weather_repository.dart';

import '../helpers/resources.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ApiClient apiClient;
  late WeatherRepository weatherRepository;

  setUp(
    () {
      apiClient = MockApiClient();

      when(
        () => apiClient.get<LocationList>(
          path: '/api/location/search/',
          params: {
            'query': 'NoLocationWithSuchANameFinded',
          },
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          true,
          LocationList(
            [],
          ),
          200,
        ),
      );

      when(
        () => apiClient.get<LocationList>(
          path: '/api/location/search/',
          params: {
            'query': 'san',
          },
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          true,
          LocationList(
            [
              Location(
                'san',
                'locationType',
                'lattLong',
                2233,
                123,
              )
            ],
          ),
          200,
        ),
      );

      when(
        () => apiClient.get<LocationList>(
          path: '/api/location/search/',
          params: {
            'lattlong': '22,11',
          },
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          true,
          LocationList(
            getLocationList(),
          ),
          200,
        ),
      );

      when(
        () => apiClient.get<LocationData>(
          path: '/api/location/3344',
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          true,
          getLocationData(),
          200,
        ),
      );

      when(
        () => apiClient.get<LocationData>(
          path: '/api/location/1313131313',
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          false,
          null,
          404,
        ),
      );

      when(
        () => apiClient.get<ConsolidatedWeatherList>(
          path: '/api/location/1313131313/2013/4/27/',
        ),
      ).thenAnswer(
        (_) async => ApiResult(
          false,
          null,
          404,
        ),
      );

      when(
        () => apiClient.get<ConsolidatedWeatherList>(
          path: '/api/location/3344/1888/4/27/',
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

      when(
        () => apiClient.get<ConsolidatedWeatherList>(
          path: '/api/location/2487956/2013/4/27/',
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

      weatherRepository = WeatherRepository(
        apiClient,
      );
    },
  );

  group(
    'WeatherRepository',
    () {
      test(
        'can be instantiated',
        () {
          expect(
            WeatherRepository(apiClient),
            isNotNull,
          );
        },
      );

      group(
        'Get location by name',
        () {
          test(
            'returns empty list of locations if api call succeeds'
            'but no location with name found',
            () async {
              final locations = await weatherRepository.locationSearchByName(
                'NoLocationWithSuchANameFinded',
              );
              expect(
                locations.data!.locations.length,
                0,
              );

              verify(
                () => apiClient.get<LocationList>(
                  path: '/api/location/search/',
                  params: {
                    'query': 'NoLocationWithSuchANameFinded',
                  },
                ),
              ).called(1);
            },
          );

          test(
            'returns list of locations if api call succeeds',
            () async {
              final locations = await weatherRepository.locationSearchByName(
                'san',
              );
              expect(
                locations.data?.locations.length,
                greaterThan(0),
              );
              verify(
                () => apiClient.get<LocationList>(
                  path: '/api/location/search/',
                  params: {
                    'query': 'san',
                  },
                ),
              ).called(1);
            },
          );
        },
      );

      group(
        'Get location by coordinates',
        () {
          test(
            'returns list of 10 nearest locations to coordinates'
            'added in search criteria if api call succeeds',
            () async {
              final locations =
                  await weatherRepository.locationSearchByCoordinates(
                '22',
                '11',
              );

              expect(
                locations.data?.locations.length,
                10,
              );

              verify(
                () => apiClient.get<LocationList>(
                  path: '/api/location/search/',
                  params: {
                    'lattlong': '22,11',
                  },
                ),
              ).called(1);
            },
          );
        },
      );

      group(
        'Get location current day information',
        () {
          test(
            'returns status code not found - 404 when'
            'no location with such an id found',
            () async {
              final locationData = await weatherRepository.locationInformation(
                '1313131313',
              );
              expect(
                locationData.statusCode,
                404,
              );
              verify(
                () => apiClient.get<LocationData>(
                  path: '/api/location/1313131313',
                ),
              ).called(1);
            },
          );

          test(
            'returns object of location data for current day'
            'with status code 200 if api call succeeds',
            () async {
              final locationData = await weatherRepository.locationInformation(
                '3344',
              );

              expect(
                locationData.wasSuccessful,
                true,
              );

              verify(
                () => apiClient.get<LocationData>(
                  path: '/api/location/3344',
                ),
              ).called(1);
            },
          );
        },
      );

      group(
        'Get location history day information',
        () {
          test(
            'returns status code not found - 404 when'
            'no location with such an id found',
            () async {
              final locationData =
                  await weatherRepository.locationDayInformation(
                '1313131313',
                '2013/4/27/',
              );
              expect(
                locationData.statusCode,
                404,
              );

              verify(
                () => apiClient.get<ConsolidatedWeatherList>(
                  path: '/api/location/1313131313/2013/4/27/',
                ),
              ).called(1);
            },
          );

          test(
            'returns empty list of location data objects if api call succeeds'
            'but no data found for history day added in search criteria',
            () async {
              final locationData =
                  await weatherRepository.locationDayInformation(
                '3344',
                '1888/4/27/',
              );
              expect(
                locationData.data!.data.length,
                0,
              );

              verify(
                () => apiClient.get<ConsolidatedWeatherList>(
                  path: '/api/location/3344/1888/4/27/',
                ),
              ).called(1);
            },
          );

          test(
            'returns list of location data objects for history day added in'
            'search criteria if api call succeeds',
            () async {
              final locationData =
                  await weatherRepository.locationDayInformation(
                '2487956',
                '2013/4/27/',
              );

              expect(
                locationData.data!.data.length,
                greaterThan(0),
              );

              verify(
                () => apiClient.get<ConsolidatedWeatherList>(
                  path: '/api/location/2487956/2013/4/27/',
                ),
              ).called(1);
            },
          );
        },
      );
    },
  );
}
