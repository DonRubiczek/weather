import 'package:json_annotation/json_annotation.dart';

part 'consolidated_weather.g.dart';

@JsonSerializable()
class ConsolidatedWeather {
  ConsolidatedWeather(
      this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.theTemp,
      this.maxTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability);

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  final num id;
  @JsonKey(name: 'weather_state_name')
  final String weatherStateName;
  @JsonKey(name: 'weather_state_abbr')
  final String weatherStateAbbr;
  @JsonKey(name: 'wind_direction_compass')
  final String windDirectionCompass;
  final String created;
  @JsonKey(name: 'applicable_date')
  final String applicableDate;
  @JsonKey(name: 'min_temp')
  final num? minTemp;
  @JsonKey(name: 'the_temp')
  final num? theTemp;
  @JsonKey(name: '(max_temp')
  final num? maxTemp;
  @JsonKey(name: 'wind_speed')
  final num? windSpeed;
  @JsonKey(name: 'wind_direction')
  final num? windDirection;
  @JsonKey(name: 'air_pressure')
  final num? airPressure;
  final num? humidity;
  final num? visibility;
  final num? predictability;

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherToJson(this);
}
