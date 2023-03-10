import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/network_result.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  DioClient._internal();

  final Dio _dio = Dio();

  Future<NetWorkResult> get(String url, Map<String, dynamic>? parameter) async {
    try {
      Response response = await _dio.get(
        url,
        queryParameters: parameter,
      );
      if (response.statusCode == 200) {
        return NetWorkResult(result: Result.success, response: response.data);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }

  Future<NetWorkResult> post(String url, dynamic data) async {
    try {
      Response response = await _dio.post(
        url,
        data: json.encode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkcmFzZ29uQG5hdmVyLmNvbSIsInJvbGUiOiJST0xFX0FETUlOX1VTRVIiLCJleHAiOjE2Nzg0NTEyOTZ9.FphSRw-2E_RNAgg6bfrxAbz1fELF9hM0xDxjsusJiJww8ZrkZLGfWqRAyIfdBO365zF1kuNnFAlPpx7NuTcXlQ',
            'RT':
                'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkcmFzZ29uQG5hdmVyLmNvbSIsInJvbGUiOiJST0xFX0FETUlOX1VTRVIiLCJleHAiOjE2NzkwNTQyOTZ9.CEBEhZ3WRUFvBATICGrGIuhtvnS8ncEk0OAD6APITdmitwfwOZeVmt4g1iI_nKNyc5ORvjzy5s7lTt3eTmPV2Q'
          },
        ),
      );
      if (response.statusCode == 200) {
        return NetWorkResult(result: Result.success, response: response.data);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }
}
