import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

enum LoadState {
  proceeding,
  success,
  fail,
}

class AuthState extends StateNotifier<LoadState> {
  AuthState() : super(LoadState.proceeding);

  @override
  set state(LoadState value) {
    // TODO: implement state
    super.state = value;
  }

  Future signIn(String email, String password) async {
    try {
      var result = await AuthService().signIn(email, password);
      if (result) {
        state = LoadState.success;
      } else {
        state = LoadState.fail;
      }
    } catch (e) {
      print(e);
      state = LoadState.fail;
    }
  }

  Future signUp(User user) async {
    try {
      bool result = await AuthService().signUp(user);
      if (result) {
        state = LoadState.success;
      } else {
        state = LoadState.fail;
      }
    } catch (e) {
      print(e);
      state = LoadState.fail;
    }
  }
}
