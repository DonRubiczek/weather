import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/repository/model/location_data.dart';

class EntityFactory {
  static T? generateOBJ<T>(
    json,
  ) {
    if (json == null) {
      return null;
    } else if (T.toString() == 'ConsolidatedWeather') {
      return ConsolidatedWeather.fromJson(
        json,
      ) as T;
    } else if (T.toString() == 'LocationData') {
      return LocationData.fromJson(
        json,
      ) as T;
    } else if (T.toString() == 'List<Location>') {
      return List<Location>.from(
        json.map(
          (model) => Location.fromJson(
            model,
          ),
        ),
      ) as T;
    } else if (T.toString() == 'List<ConsolidatedWeather>') {
      return List<ConsolidatedWeather>.from(
        json.map(
          (model) => ConsolidatedWeather.fromJson(
            model,
          ),
        ),
      ) as T;
    } else {
      return null;
    }
  }
}
