import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/model/survey_audit.dart';
import 'package:diviction_user/model/survey_dass.dart';
import 'package:diviction_user/model/survey_dast.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

import '../model/user.dart';

const storage = fss.FlutterSecureStorage();

class SurveyService {
  static final SurveyService _authService = SurveyService._internal();
  factory SurveyService() {
    return _authService;
  }
  SurveyService._internal();

  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<bool> DASTdataSave(SurveyDAST surveyDAST) async {
    try {
      NetWorkResult result = await DioClient()
          .post('$_baseUrl/dast/save', surveyDAST.toJson(), false);
      print(result.result);
      if (result.result == Result.success) {
        return true;
      } else {
        throw false;
      }
    } catch (e) {
      throw false;
    }
  }

  Future<bool> DASSdataSave(SurveyDASS surveyDASS) async {
    try {
      NetWorkResult result = await DioClient()
          .post('$_baseUrl/dass/save', surveyDASS.toJson(), false);
      print(result.result);
      if (result.result == Result.success) {
        return true;
      } else {
        throw false;
      }
    } catch (e) {
      throw false;
    }
  }

  Future<dynamic> AUDITdataSave(SurveyAUDIT surveyAUDIT) async {
    try {
      NetWorkResult result = await DioClient()
          .post('$_baseUrl/audit/save', surveyAUDIT.toJson(), false);
      print(result.result);
      if (result.result == Result.success) {
        return true;
      } else {
        throw false;
      }
    } catch (e) {
      throw false;
    }
  }

  Future<NetWorkResult> DASTdataGet(String member_email, String date) async {
    try {
      NetWorkResult result = await DioClient().post(
          '$_baseUrl/dast/get',
          {
            'member_email': member_email,
            'date': date,
          },
          false);
      print(result.response);
      if (result.result == Result.success) {
        return NetWorkResult(result: Result.success, response: result.response);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } catch (e) {
      return NetWorkResult(result: Result.fail, response: e);
    }
  }

  Future<NetWorkResult> DASSdataGet(int memberId) async {
    try {
      NetWorkResult result = await DioClient()
          .get('$_baseUrl/dass/list/member/$memberId', {}, false);
      print(result.response);
      if (result.result == Result.success) {
        return NetWorkResult(result: Result.success, response: result.response);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } catch (e) {
      return NetWorkResult(result: Result.fail, response: e);
    }
  }

  Future<NetWorkResult> AUDITdataGet(int memberId) async {
    try {
      NetWorkResult result = await DioClient()
          .get('$_baseUrl/audit/list/member/$memberId', {}, false);
      print(result.response);
      if (result.result == Result.success) {
        return NetWorkResult(result: Result.success, response: result.response);
      } else {
        return NetWorkResult(result: Result.fail);
      }
    } catch (e) {
      return NetWorkResult(result: Result.fail, response: e);
    }
  }
}
