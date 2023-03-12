import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/network/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;

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
    try {
      if (acToken == null) {
        return false;
      } else {
        NetWorkResult result = await DioClient()
            .post('$_baseUrl/auth/validate/token', {'token': acToken}, true);
        if (result.result == Result.success) {
          return result.response;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      NetWorkResult result = await DioClient().post(
          '$_baseUrl/auth/signIn/member',
          {
            'email': email,
            'password': password,
            'authority': 'ROLE_ADMIN_USER'
          },
          false);
      if (result.result == Result.success) {
        //   storage.write(
        //     key: 'accessToken', value: result.response['accessToken']);
        // storage.write(
        //     key: 'refreshToken', value: result.response['refreshToken']);
        return result.response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
  }
}
