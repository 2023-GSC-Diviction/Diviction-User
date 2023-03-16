import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

enum SignState { proceeding, success, fail }

class AuthState extends StateNotifier<SignState> {
  AuthState() : super(SignState.proceeding);

  @override
  set state(SignState value) {
    // TODO: implement state
    super.state = value;
  }

  Future signIn(String email, String password) async {
    try {
      var result = await AuthService().signIn(email, password);
      if (result) {
        state = SignState.success;
      } else {
        state = SignState.fail;
      }
    } catch (e) {
      print(e);
      state = SignState.fail;
    }
  }

  Future signUp(User user) async {
    try {
      bool result = await AuthService().signUp(user);
      if (result) {
        state = SignState.success;
      } else {
        state = SignState.fail;
      }
    } catch (e) {
      print(e);
      state = SignState.fail;
    }
  }
}
