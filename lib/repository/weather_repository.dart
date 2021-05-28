import 'package:weather/api/api_client.dart';
import 'package:weather/api/api_result.dart';
import 'package:weather/repository/model/consolidated_weather_list.dart';
import 'package:weather/repository/model/location_list.dart';

import 'model/location_data.dart';

class WeatherRepository {
  WeatherRepository(this.client);

  final ApiClient client;

  Future<ApiResult<LocationList>> locationSearchByName(String location) async {
    final result = await client.get<LocationList>(
      path: '/api/location/search/',
      params: {
        'query': location,
      },
    );

    return result;
  }

  Future<ApiResult<LocationList>> locationSearchByCoordinates(
      String lattitude, String longitude) async {
    final result = await client.get<LocationList>(
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

  Future<ApiResult<ConsolidatedWeatherList>> locationDayInformation(
      String locationId, String date) async {
    final result = await client.get<ConsolidatedWeatherList>(
      path: '/api/location/$locationId/$date',
    );

    return result;
  }
}
