import 'package:dio/dio.dart';
import 'package:weather/utils/constants.dart';

Dio initializeDio() {
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        seconds: 5,
      ).inMilliseconds,
      receiveTimeout: const Duration(
        seconds: 10,
      ).inMilliseconds,
      baseUrl: CONSTANTS.baseUrl,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  return _dio;
}

Dio dio = initializeDio();
