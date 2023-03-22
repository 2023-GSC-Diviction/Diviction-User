import 'package:shared_preferences/shared_preferences.dart';

class getUserData {
  static Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('id');
    if(userId == null) {
      print('SharedPreferences에 userID의 정보가 없습니다.');
      return -1;
    }
    else {
      print('getUserData - userId : $userId');
      return userId!;
    }
  }

  static Future<String> getUserEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userEmail = pref.getString('email');
    if(userEmail == null) {
      print('SharedPreferences에 userEmail의 정보가 없습니다.');
      return '';
    }
    else {
      print('getUserData - userEmail : $userEmail');
      return userEmail!;
    }
  }
}