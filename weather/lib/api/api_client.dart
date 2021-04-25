import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/api/entity_factory.dart';

import 'api_error.dart';
import 'api_result.dart';

class ApiClient {
  ApiClient(
    this.dio,
  );

  final Dio dio;

  Future<ApiResult<TResult>> get<TResult>({
    required String path,
    Map<String, dynamic>? params,
    bool localized = false,
    bool withToken = false,
  }) async {
    params = params ?? <String, dynamic>{};

    try {
      // logger.d(
      //   'Calling GET request at $path with params $params.'
      //   'Localized: $localized. WithOptions: $withToken',
      // );

      final response = await dio.get<String>(
        path,
        queryParameters: params,
      );

      // logger.d(
      //   'GET request finished with '
      //   'request code: ${response.statusCode} and '
      //   'message: ${response.statusMessage}',
      // );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.data!);
        final data = EntityFactory.generateOBJ<TResult>(json);
        return ApiResult<TResult>(true, data, 200);
      } else {
        return ApiResult<TResult>(false, null, response.statusCode);
      }
    } on DioError catch (e) {
      // logger.e(
      //     'HTTP error during GET request. '
      //     '${e.response?.statusCode}:${e.response?.statusMessage}, ${e.error}',
      //     e,
      //     s);
      if (e.response == null) {
        return ApiResult<TResult>(false, null, ApiError.noNetwork);
      }
      return ApiResult<TResult>(false, null, e.response?.statusCode);
    } catch (e, s) {
      //logger.e('Error during fetching hierarchy from API', e, s);
      return ApiResult<TResult>(false, null, -1);
    }
  }
}
