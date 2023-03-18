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

  _checkToken(Headers headers) {
    if (headers.value('accessToken') != null) {
      _tokenRefresh(
          headers.value('accessToken')!, headers.value('refreshToken')!);
    }
  }

  _tokenRefresh(String acToken, String refToken) async {
    storage.write(key: 'accessToken', value: acToken);
    storage.write(key: 'refreshToken', value: refToken);

    _acToken = acToken;
    _refToken = refToken;
  }

  Future<NetWorkResult> get(
      String url, Map<String, dynamic>? parameter, bool useToken) async {
    try {
      Response response = await _dio.get(url,
          queryParameters: parameter,
          options: useToken
              ? Options(headers: {
                  HttpHeaders.authorizationHeader: _acToken,
                  HttpHeaders.contentTypeHeader: 'application/json',
                  'Content-Type': 'application/json',
                  'RT': _refToken
                })
              : Options(headers: {
                  HttpHeaders.contentTypeHeader: 'application/json',
                  'Content-Type': 'application/json',
                }));
      if (response.statusCode == 200) {
        print("[200] 요청성공");
        _checkToken(response.headers);
        return NetWorkResult(result: Result.success, response: response.data);
      } else if (response.statusCode == 401) {
        if (response.headers.value('CODE') == 'RTE') {
          print("[401] 요청실패 RTE");
          return NetWorkResult(result: Result.tokenExpired);
        } else {
          print("[401] 요청실패 ETC");
          return NetWorkResult(result: Result.fail);
        }
      } else {
        print("[500] 서버에서 처리가 안됌");
        _checkToken(response.headers);
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('[DioError]');
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        print('[DioError]');
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }

  Future<NetWorkResult> post(String url, dynamic data, bool useToken) async {
    try {
      Response response = await _dio.post(
        url,
        data: json.encode(data),
        options: useToken
            ? Options(
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json',
                  // HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMUBnbWFpbC5jb20iLCJyb2xlIjoiUk9MRV9VU0VSIiwiZXhwIjoxNjc4OTc4NTU4fQ.-V7EAermuJTgi7oiCOa_tD8XhSvNo42km8dxs8aVniNvm0UiGEA_1wPY_YBSvym-kObOAXe4KuO4fdeTBQeOxw', // AT
                  // 'RT': 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMUBnbWFpbC5jb20iLCJyb2xlIjoiUk9MRV9VU0VSIiwiZXhwIjoxNjc5NTgxNTU4fQ.NB3w7QZfdvZ4kG7N8Pw2F_sh2rVJ-fKyiDN8ad24P2a9bhQE-4Dc4sTM-aRIPzNwetEL5bdCIDcteahNFY2c8g', // RT
                },
              )
            : Options(
                headers: {
                  HttpHeaders.contentTypeHeader: 'application/json',
                },
              ),
      );
      if (response.statusCode == 200) {
        print("[200] 요청성공");
        _checkToken(response.headers);
        return NetWorkResult(result: Result.success, response: response.data);
      } else if (response.statusCode == 401) {

        if (response.headers.value('CODE') == 'RTE') {
          print("[401] 요청실패 RTE");
          return NetWorkResult(result: Result.tokenExpired);
        } else {
          print("[401] 요청실패 ETC");
          return NetWorkResult(result: Result.fail);
        }
      } else {
        print("[500] 서버에서 처리가 안됌");
        _checkToken(response.headers);
        return NetWorkResult(result: Result.fail);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('[DioError]');
        return NetWorkResult(result: Result.fail, response: e.response);
      } else {
        print('[DioError]');
        return NetWorkResult(result: Result.fail, response: e);
      }
    }
  }
}
