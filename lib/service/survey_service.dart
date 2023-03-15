import 'package:diviction_user/model/network_result.dart';
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

  Future<bool> DSATdataSave(SurveyDAST surveyDAST) async {
    try {
      NetWorkResult result = await DioClient().post(
          '$_baseUrl/dast/save',
          surveyDAST.toJson(),
          true);
      print(result);
      if (result.result == Result.success) {
        return true;
      } else {
        throw false;
      }
    } catch (e) {
      throw false;
    }
  }
}
