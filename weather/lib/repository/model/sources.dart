import 'package:json_annotation/json_annotation.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources {
  Sources(this.title, this.url);

  final String title;
  final String url;

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);
  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}
