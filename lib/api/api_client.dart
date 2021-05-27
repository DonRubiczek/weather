import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/api/entity_factory.dart';

import 'api_error.dart';
import 'api_result.dart';

class ApiClient {
  ApiClient(this.dio);

  final Dio dio;

  Future<ApiResult<TResult>> get<TResult>({
    required String path,
    Map<String, dynamic>? params,
    bool localized = false,
    bool withToken = false,
  }) async {
    params = params ?? <String, dynamic>{};

    try {
      final response = await dio.get<String>(
        path,
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(
          response.data!,
        );
        final data = EntityFactory.generateOBJ<TResult>(
          json,
        );
        return ApiResult<TResult>(
          true,
          data,
          200,
        );
      } else {
        return ApiResult<TResult>(
          false,
          null,
          response.statusCode,
        );
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ApiResult<TResult>(
          false,
          null,
          ApiError.noNetwork,
        );
      }
      return ApiResult<TResult>(
        false,
        null,
        e.response?.statusCode,
      );
    } catch (e) {
      return ApiResult<TResult>(
        false,
        null,
        -1,
      );
    }
  }
}
