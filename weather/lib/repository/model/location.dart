import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location(
      this.title, this.locationType, this.lattLong, this.woeid, this.distance);

  final String title;
  @JsonKey(name: 'location_type')
  final String locationType;
  @JsonKey(name: 'latt_long')
  final String lattLong;
  final int woeid;
  final int? distance;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
