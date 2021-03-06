// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consolidated_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) {
  return ConsolidatedWeather(
    json['id'] as num,
    json['weather_state_name'] as String,
    json['weather_state_abbr'] as String,
    json['wind_direction_compass'] as String,
    json['created'] as String,
    json['applicable_date'] as String,
    json['min_temp'] as num?,
    json['the_temp'] as num?,
    json['max_temp'] as num?,
    json['wind_speed'] as num?,
    json['wind_direction'] as num?,
    json['air_pressure'] as num?,
    json['humidity'] as num?,
    json['visibility'] as num?,
    json['predictability'] as num?,
  );
}

Map<String, dynamic> _$ConsolidatedWeatherToJson(
        ConsolidatedWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'wind_direction_compass': instance.windDirectionCompass,
      'created': instance.created,
      'applicable_date': instance.applicableDate,
      'min_temp': instance.minTemp,
      'the_temp': instance.theTemp,
      'max_temp': instance.maxTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };
