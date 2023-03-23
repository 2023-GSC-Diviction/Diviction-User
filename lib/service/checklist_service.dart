import 'package:diviction_user/model/checklist.dart';
import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistService {
  static final ChecklistService _checklistService =
      ChecklistService._internal();

  factory ChecklistService() {
    return _checklistService;
  }

  ChecklistService._internal();

  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<List<CheckList>> getChecklists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int id = prefs.getInt('id')!;

    final response = await DioClient()
        .get('$_baseUrl/checklist/get/today/$id', {'patient_id': id}, true);
    if (response.result == Result.success) {
      List<CheckList> checklist = response.response
          .map((counselor) {
            return CheckList.fromJson(counselor);
          })
          .cast<CheckList>()
          .toList();
      return checklist;
    } else {
      throw Exception('Failed to load checklists from API');
    }
  }
}
