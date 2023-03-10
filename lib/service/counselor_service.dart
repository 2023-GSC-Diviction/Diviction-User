import 'package:diviction_user/model/user.dart';
import 'package:diviction_user/network/dio_client.dart';

import '../model/counselor.dart';
import '../model/network_result.dart';

class CounselorService {
  static final CounselorService _counselorService =
      CounselorService._internal();
  factory CounselorService() {
    return _counselorService;
  }
  CounselorService._internal();

  Future<List<Counselor>> getCounselorsByOption(
      Map<String, String> option) async {
    var response = await DioClient().post(
        'http://15.164.100.67:8080/checklist/get',
        {"patientId": 1, "startDate": "2023-03-10", "endDate": "2023-03-10"});

    if (response.result == Result.success) {
      var counselors = response.response['counselors'];
      return counselors
          .map((counselor) => Counselor.fromJson(counselor))
          .toList();
    } else {
      throw Exception('Failed to load counselors');
    }
  }
}
