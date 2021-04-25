// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['title'] as String,
    json['location_type'] as String,
    json['latt_long'] as String,
    json['woeid'] as int,
    json['distance'] as int?,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'latt_long': instance.lattLong,
      'woeid': instance.woeid,
      'distance': instance.distance,
    };
