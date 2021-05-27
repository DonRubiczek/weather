import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable()
class Parent {
  Parent(this.title, this.locationType, this.lattLong, this.woeid);

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  final String title;
  @JsonKey(name: 'location_type')
  final String locationType;
  @JsonKey(name: 'latt_long')
  final String lattLong;
  final int woeid;

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
