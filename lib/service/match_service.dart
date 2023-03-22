import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MatchingService {
  static final MatchingService _authService = MatchingService._internal();
  factory MatchingService() {
    return _authService;
  }
  MatchingService._internal();

  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<bool> createMatch(int userId, int counselorId) async {
    try {
      NetWorkResult result = await DioClient().post(
          '$_baseUrl/match/save',
          {
            'patientId': userId,
            'counselorId': counselorId,
          },
          true);
      if (result.result == Result.success) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Stream<List<Match>> getMatches() {
  //   return _matchCollection.snapshots().map((snapshot) {
  //     return snapshot.documents.map((doc) {
  //       return Match.fromJson(doc.data);
  //     }).toList();
  //   });
  // }
}
