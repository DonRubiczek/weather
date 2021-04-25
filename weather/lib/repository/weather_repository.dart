import 'package:weather/api/api_client.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';

import 'model/location_data.dart';

class WeatherRepository {
  WeatherRepository(this.client);

  final ApiClient client;

  Future<ApiResult<List<Location>>> locationSearchByName(
      String location) async {
    final result = await client.get<List<Location>>(
      path: '/api/location/search/',
      params: {
        'query': location,
      },
    );

    return result;
  }

  Future<ApiResult<List<Location>>> locationSearchByCoordinates(
      String lattitude, String longitude) async {
    final result = await client.get<List<Location>>(
      path: '/api/location/search/',
      params: {
        'lattlong': '$lattitude,$longitude',
      },
    );

    return result;
  }

  Future<ApiResult<LocationData>> locationInformation(String locationId) async {
    final result = await client.get<LocationData>(
      path: '/api/location/$locationId',
    );

    return result;
  }

  Future<ApiResult<List<ConsolidatedWeather>>> locationDayInformation(
      String locationId, String date) async {
    final result = await client.get<List<ConsolidatedWeather>>(
      path: '/api/location/$locationId/$date',
    );

    return result;
  }
}
