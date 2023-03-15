import 'package:diviction_user/model/survey_dast.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/service/survey_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

enum TestState { proceeding, success, fail }

class SurveyState extends StateNotifier<TestState> {
  SurveyState() : super(TestState.proceeding);

  @override
  set state(TestState value) {
    // TODO: implement state
    super.state = value;
  }

  Future DSATdataSave(SurveyDAST surveyDAST) async {
    try {
      var result = await SurveyService().DSATdataSave(surveyDAST);
      if (result) {
        state = TestState.success;
      } else {
        state = TestState.fail;
      }
    } catch (e) {
      print(e);
      state = TestState.fail;
    }
  }
}
