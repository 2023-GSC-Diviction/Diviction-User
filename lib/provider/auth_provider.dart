import 'package:diviction_user/service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future SignupWithloadImage(String path, Map<String, String> user) async {
    try {
      var result =
          await AuthService().SignupWithloadImage(path: path, user: user);
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

  saveData(String email) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') == null || prefs.getString('email') != email) {
      AuthService().getUser(email);
    }
  }
}
