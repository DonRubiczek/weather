import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/consolidated_weather_list.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';
import 'package:weather/repository/model/location_list.dart';

class EntityFactory {
  static T? generateOBJ<T>(
    json,
  ) {
    if (json == null) {
      return null;
    } else if (T == ConsolidatedWeather) {
      return ConsolidatedWeather.fromJson(
        json,
      ) as T;
    } else if (T == LocationData) {
      return LocationData.fromJson(
        json,
      ) as T;
    } else if (T == LocationList) {
      var list = List<Location>.from(
        json.map(
          (model) => Location.fromJson(
            model,
          ),
        ),
      );

      return LocationList(list) as T;
    } else {
      if (T == ConsolidatedWeatherList) {
        var list = List<ConsolidatedWeather>.from(
          json.map(
            (model) => ConsolidatedWeather.fromJson(
              model,
            ),
          ),
        );
        return ConsolidatedWeatherList(list) as T;
      } else {
        return null;
      }
    }
  }
}
