import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

import '../model/network_result.dart';

const storage = fss.FlutterSecureStorage();

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  String? _acToken;
  String? _refToken;
  final Dio _dio = Dio();

  DioClient._internal() {
    _getToken();
  }

  _getToken() async {
    _acToken = await storage.read(key: 'accessToken');
    _refToken = await storage.read(key: 'refreshToken');
  }

  _tokenRefresh(String acToken, String refToken) async {
    storage.write(key: 'accessToken', value: acToken);
    storage.write(key: 'refreshToken', value: refToken);

    _acToken = acToken;
    _refToken = refToken;
  }

  Future<NetWorkResult> get(String url, Map<String, dynamic>? parameter) async {
    try {
      Response response = await _dio.get(url,
          queryParameters: parameter,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $_acToken',
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'RT': _refToken
          }));
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

  Future<NetWorkResult> post(String url, dynamic data, bool useToken) async {
    print(_dio.options);
    try {
      Response response = await _dio.post(url,
          data: json.encode(data),
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              'Content-Type': 'application/json',
            },
          ));
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
