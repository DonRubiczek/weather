import 'package:weather/api/entity_factory.dart';

class ApiResult<T> {
  ApiResult(
    this.wasSuccessful,
    this.data,
    this.statusCode,
  );

  final bool wasSuccessful;
  final T? data;
  final int? statusCode;

  factory ApiResult.fromJson(json) {
    if (json['Data'] != null) {
      return ApiResult(
        true,
        EntityFactory.generateOBJ<T>(json['Data']),
        json['Code'],
      );
    } else {
      return ApiResult(
        false,
        null,
        json['Code'],
      );
    }
  }
}
