import 'package:diviction_user/model/user.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/counselor.dart';
import '../model/network_result.dart';

class CounselorService {
  static final CounselorService _counselorService =
  CounselorService._internal();
  factory CounselorService() {
    return _counselorService;
  }
  CounselorService._internal();
  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<List<Counselor>> getCounselors(Map<String, String> option) async {
    var response = await DioClient().get('$_baseUrl/counselor/all', {}, true);

    if (response.result == Result.success) {
      var res = response.response;
      List<Counselor> counselors = res
          .map((counselor) {
        return Counselor.fromJson(counselor);
      })
          .cast<Counselor>()
          .toList();

      return counselors;
    } else {
      throw Exception('Failed to load counselors');
    }
  }
}
