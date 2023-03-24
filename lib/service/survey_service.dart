import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/model/survey_audit.dart';
import 'package:diviction_user/model/survey_dass.dart';
import 'package:diviction_user/model/survey_dast.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

const storage = fss.FlutterSecureStorage();

class SurveyService {
  static final SurveyService _authService = SurveyService._internal();
  factory SurveyService() {
    return _authService;
  }

  SurveyService._internal() {
    // getUserId();
  }

  int userId = 1;
  late SharedPreferences prefs;

  // getUserId() async {
  //   prefs = await SharedPreferences.getInstance();
  //   userId = prefs.getInt('id')!;
  // }

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

  Future<List<Map<String, dynamic>>> DASTdataGet() async {
    try {
      NetWorkResult result = await DioClient()
          .get('$_baseUrl/dast/list/member/${userId}', {}, false);
      print('result.response.runtimeType : ${result.response.runtimeType}, result.response : ${result.response}');
      print('return type : ${result.response.cast<Map<String, dynamic>>().runtimeType}');
      if (result.result == Result.success) {
        return result.response.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      print('Error : $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> DASSdataGet() async {
    try {
      NetWorkResult result = await DioClient()
          .get('$_baseUrl/dass/list/member/$userId', {}, false);
      // print(result.response);
      if (result.result == Result.success) {
        return result.response.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      print('Error : $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> AUDITdataGet() async {
    try {
      NetWorkResult result = await DioClient()
          .get('$_baseUrl/audit/list/member/$userId', {}, false);
      // print(result.response);
      if (result.result == Result.success) {
        return result.response.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      print('Error : $e');
      return [];
    }
  }
}
