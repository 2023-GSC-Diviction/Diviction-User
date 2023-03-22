import 'package:diviction_user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUser {
  static Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('id');
    if (userId == null) {
      print('SharedPreferences에 userID의 정보가 없습니다.');
      return -1;
    } else {
      print('getUserData - userId : $userId');
      return userId!;
    }
  }

  static Future<String> getUserEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userEmail = pref.getString('email');
    if (userEmail == null) {
      print('SharedPreferences에 userEmail의 정보가 없습니다.');
      return '';
    } else {
      print('getUserData - userEmail : $userEmail');
      return userEmail!;
    }
  }

  // Future<User> getUserData() async{

  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   int userId = await pref.getInt('id')!;
  //   String userEmail = pref.getString('email')!;
  //   String userName = pref.getString('name')!;
  //   String userAddress = pref.getString('address')!;
  //   String userBirth = pref.getString('birth')!;
  //   String userPassword = pref.getString('password')!;
  //   String userGender = pref.getString('gender')!;

  // return User(id: userId, email: userEmail, password: userEmail, name: userName, address: userAddress, birth: userBirth, gender: gender)

  // }
}
