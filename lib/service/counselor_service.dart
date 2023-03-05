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
    var response =
        await DioClient().get('http://localhost:3000/counselors', option);
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
