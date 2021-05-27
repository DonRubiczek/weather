import 'package:json_annotation/json_annotation.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources {
  Sources(this.title, this.url);

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);

  final String title;
  final String url;

  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}
