import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

const storage = fss.FlutterSecureStorage();

class AuthService {
  static final AuthService _authService = AuthService._internal();
  factory AuthService() {
    return _authService;
  }
  AuthService._internal();

  final String? _baseUrl = dotenv.env['BASE_URL'];

  Future<bool> isLogin() async {
    String? acToken = await storage.read(key: 'accessToken');
    String? rfToken = await storage.read(key: 'refreshToken');
    try {
      if (acToken == null && rfToken == null) {
        return false;
      } else {
        NetWorkResult result = await DioClient().post(
            '$_baseUrl/auth/validate/token',
            {
              'accessToken': acToken,
              'refreshToken': rfToken,
              'authority': 'ROLE_USER'
            },
            false);
        if (result.result == Result.success) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      NetWorkResult result = await DioClient().post(
          '$_baseUrl/auth/signIn/member',
          {'email': email, 'password': password, 'authority': 'ROLE_USER'},
          false);
      if (result.result == Result.success) {
        final token = result.response['token'];
        storage.write(key: 'accessToken', value: token['accessToken']);
        storage.write(key: 'refreshToken', value: token['refreshToken']);
        getUser(email);
        return true;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<bool> signUp(Map<String, String> user) async {
    try {
      NetWorkResult result =
          await DioClient().post('$_baseUrl/auth/signUp/member', user, false);
      if (result.result == Result.success) {
        User user = User.fromJson(result.response);
        user.savePreference(user);

        return true;
      } else {
        throw Exception('Failed to signUp');
      }
    } catch (e) {
      throw Exception('Failed to signUp');
    }
  }

  Future<bool> emailCheck(String email, String role) async {
    try {
      NetWorkResult result = await DioClient().get(
          '$_baseUrl/auth/check/email/$email/role/$role',
          {'email': email, 'role': role},
          false);
      if (result.result == Result.success) {
        return result.response;
      } else {
        throw Exception('Failed to emailCheck');
      }
    } catch (e) {
      throw Exception('Failed to emailCheck');
    }
  }

  Future getUser(String email) async {
    try {
      NetWorkResult result = await DioClient().get(
          '$_baseUrl/member/get/email/$email', {'user_email': email}, true);
      if (result.result == Result.success) {
        User user = User.fromJson(result.response);
        user.savePreference(user);
      } else {
        throw Exception('Failed to getUser');
      }
    } catch (e) {
      throw Exception('Failed to getUser');
    }
  }

  getMatched() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('id');
      if (id != null) {
        NetWorkResult result = await DioClient()
            .get('$_baseUrl/member/match/$id', {'id': id}, true);
        if (result.result == Result.success) {
          final email = prefs.getString('email');
          return ('${result.response['counselorEmail']}&$email')
              .replaceAll('.', '');
        } else {
          throw false;
        }
      }
    } catch (e) {
      throw e;
    }
  }
}
