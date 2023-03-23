import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:diviction_user/model/match.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Match?> getMatched() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('id');
      if (id != null) {
        NetWorkResult result = await DioClient()
            .get('$_baseUrl/member/match/$id', {'id': id}, true);
        if (result.result == Result.success && result.response != null) {
          Match match = Match.fromJson(result.response);
          return match;
        } else if (result.result == Result.success && result.response == null) {
          return null;
        } else {
          throw Exception('Failed to getMatched');
        }
      }
    } catch (e) {
      throw e;
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
