import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState extends StateNotifier<bool> {
  AuthState() : super(false);

  @override
  set state(bool value) {
    // TODO: implement state
    super.state = value;
  }

  Future login(String email, String password) async {
    var result = await AuthService().login(email, password);
    state = result;
  }
}
