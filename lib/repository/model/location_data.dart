import 'package:json_annotation/json_annotation.dart';
import 'package:weather/repository/model/consolidated_weather.dart';
import 'package:weather/repository/model/parent.dart';
import 'package:weather/repository/model/sources.dart';

part 'location_data.g.dart';

@JsonSerializable()
class LocationData {
  LocationData(
      this.consolidatedWeatherData,
      this.time,
      this.sunRise,
      this.sunSet,
      this.timezoneName,
      this.parent,
      this.sources,
      this.title,
      this.locationType,
      this.woeid,
      this.lattlong,
      this.timezone);

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  @JsonKey(name: 'consolidated_weather')
  final List<ConsolidatedWeather> consolidatedWeatherData;
  final String time;
  @JsonKey(name: 'sun_rise')
  final String sunRise;
  @JsonKey(name: 'sun_set')
  final String sunSet;
  @JsonKey(name: 'timezone_name')
  final String timezoneName;
  final Parent parent;
  final List<Sources> sources;
  final String title;
  @JsonKey(name: 'location_type')
  final String locationType;
  final num woeid;
  @JsonKey(name: 'latt_long')
  final String lattlong;
  final String timezone;

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}
