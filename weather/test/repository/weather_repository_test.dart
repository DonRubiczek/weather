import 'package:flutter_test/flutter_test.dart';
import 'package:weather/api/api_client.dart';
import 'package:weather/api/dio.dart';
import 'package:weather/repository/weather_repository.dart';

void main() {
  late ApiClient apiClient;
  late WeatherRepository weatherRepository;

  setUp(
    () {
      apiClient = ApiClient(dio);
      weatherRepository = WeatherRepository(apiClient);
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
              final locations = await weatherRepository
                  .locationSearchByName('NoLocationWithSuchANameFinded');
              expect(locations.data!.length, 0);
            },
          );

          test(
            'returns list of locations if api call succeeds',
            () async {
              final locations =
                  await weatherRepository.locationSearchByName('San');
              expect(locations.data?.length, greaterThan(0));
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
              final locations = await weatherRepository
                  .locationSearchByCoordinates('11', '11');

              expect(locations.data?.length, 10);
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
              final locationData =
                  await weatherRepository.locationInformation('1313131313');
              expect(locationData.statusCode, 404);
            },
          );

          test(
            'returns object of location data for current day'
            'with status code 200 if api call succeeds',
            () async {
              final locationData =
                  await weatherRepository.locationInformation('2487956');

              expect(locationData.wasSuccessful, true);
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
              final locationData = await weatherRepository
                  .locationDayInformation('1313131313', '2013/4/27/');
              expect(locationData.statusCode, 404);
            },
          );

          test(
            'returns empty list of location data objects if api call succeeds'
            'but no data found for history day added in search criteria',
            () async {
              final locationData = await weatherRepository
                  .locationDayInformation('2487956', '1888/4/27/');
              expect(locationData.data!.length, 0);
            },
          );

          test(
            'returns list of location data objects for history day added in'
            'search criteria if api call succeeds',
            () async {
              final locationData = await weatherRepository
                  .locationDayInformation('2487956', '2013/4/27/');

              expect(locationData.data!.length, greaterThan(0));
            },
          );
        },
      );
    },
  );
}
