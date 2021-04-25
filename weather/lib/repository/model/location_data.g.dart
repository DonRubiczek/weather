// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return LocationData(
    (json['consolidated_weather'] as List<dynamic>)
        .map((e) => ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['time'] as String,
    json['sun_rise'] as String,
    json['sun_set'] as String,
    json['timezone_name'] as String,
    Parent.fromJson(json['parent'] as Map<String, dynamic>),
    (json['sources'] as List<dynamic>)
        .map((e) => Sources.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as num,
    json['latt_long'] as String,
    json['timezone'] as String,
  );
}

Map<String, dynamic> _$LocationDataToJson(LocationData instance) =>
    <String, dynamic>{
      'consolidated_weather': instance.consolidatedWeatherData,
      'time': instance.time,
      'sun_rise': instance.sunRise,
      'sun_set': instance.sunSet,
      'timezone_name': instance.timezoneName,
      'parent': instance.parent,
      'sources': instance.sources,
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattlong,
      'timezone': instance.timezone,
    };
