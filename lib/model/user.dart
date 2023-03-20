import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String email;
  String password;
  String name;
  String birth;
  String address;
  String gender;
  String? profile_img_url;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.address,
      required this.birth,
      required this.gender,
      this.profile_img_url});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        name: json['name'],
        address: json['address'],
        gender: json['gender'],
        birth: json['birth'],
        profile_img_url: json['profile_img_url']);
  }

  savePreference(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', user.id);
    pref.setString('email', user.email);
    pref.setString('password', user.password);
    pref.setString('name', user.name);
    pref.setString('address', user.address);
    pref.setString('birth', user.birth);
    pref.setString('gender', user.gender);
    user.profile_img_url == null
        ? pref.setString('profile_img_url', '')
        : pref.setString('profile_img_url', user.profile_img_url!);
  }
}
