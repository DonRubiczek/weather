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
      baseUrl: CONSTANTS.BASE_URL,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  // _dio.interceptors.add(
  //   DioCacheManager(
  //     CacheConfig(
  //       defaultMaxAge: const Duration(
  //         minutes: 5,
  //       ),
  //     ),
  //   ).interceptor as Interceptor,
  // );

  // _dio.interceptors.add(
  //   PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: false,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90,
  //   ),
  // );

  // final _retryInterceptor = RetryInterceptor(
  //   dio: _dio,
  //   errorCallback: (e) {
  //     logger.e('Retryed requred failed.', e);
  //   },
  //   options: RetryOptions(
  //     retries: 3,
  //     retryInterval: Duration(seconds: 2),
  //     retryEvaluator: (e) => e.type != DioErrorType.CONNECT_TIMEOUT,
  //   ),
  // );

  // _dio.interceptors.add(_retryInterceptor);

  return _dio;
}

Dio dio = initializeDio();
