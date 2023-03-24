import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/model/survey_audit.dart';
import 'package:diviction_user/model/survey_dass.dart';
import 'package:diviction_user/model/survey_dast.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/service/survey_service.dart';
import 'package:diviction_user/util/getUserData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

enum SaveState { proceeding, success, fail }

class SurveyState extends StateNotifier<SaveState> {
  SurveyState() : super(SaveState.proceeding);

  @override
  set state(SaveState value) {
    // TODO: implement state
    super.state = value;
  }

  Future DASTdataSave(SurveyDAST surveyDAST) async {
    try {
      var result = await SurveyService().DASTdataSave(surveyDAST);
      if (result) {
        state = SaveState.success;
        print("DAST 데이터 저장완료");
      } else {
        state = SaveState.fail;
        print("DAST 데이터 저장실패");
      }
    } catch (e) {
      print(e);
      state = SaveState.fail;
      print("DAST 데이터 저장오류");
    }
  }

  Future DASSdataSave(SurveyDASS surveyDASS) async {
    try {
      var result = await SurveyService().DASSdataSave(surveyDASS);
      if (result) {
        state = SaveState.success;
        print("DASS 데이터 저장완료");
      } else {
        state = SaveState.fail;
        print("DASS 데이터 저장실패");
      }
    } catch (e) {
      print(e);
      state = SaveState.fail;
      print("DASS 데이터 저장오류");
    }
  }

  Future AUDITdataSave(SurveyAUDIT surveyAUDIT) async {
    try {
      var result = await SurveyService().AUDITdataSave(surveyAUDIT);
      if (result) {
        state = SaveState.success;
        print("AUDIT 데이터 저장완료");
      } else {
        state = SaveState.fail;
        print("AUDIT 데이터 저장실패");
      }
    } catch (e) {
      print(e);
      state = SaveState.fail;
      print("AUDIT 데이터 저장오류");
    }
  }

  // Future DASTdataGet() async {
  //   try {
  //     var result = await SurveyService().DASTdataGet();
  //     if (result.result == Result.success) {
  //       state = SaveState.success;
  //       print("DAST 데이터 불러오기 완료");
  //     } else {
  //       state = SaveState.fail;
  //       print("DAST 데이터 불러오기 실패");
  //     }
  //   } catch (e) {
  //     print(e);
  //     state = SaveState.fail;
  //     print("DAST 데이터 불러오기 오류");
  //   }
  // }
  //
  // Future DASSdataGet() async {
  //   try {
  //     var result = await SurveyService().DASSdataGet();
  //     if (result.result == Result.success) {
  //       state = SaveState.success;
  //       print("DASS 데이터 불러오기 완료");
  //     } else {
  //       state = SaveState.fail;
  //       print("DASS 데이터 불러오기 실패");
  //     }
  //   } catch (e) {
  //     print(e);
  //     state = SaveState.fail;
  //     print("DASS 데이터 불러오기 오류");
  //   }
  // }
  //
  // Future AUDITdataGet() async {
  //   try {
  //     var result = await SurveyService().AUDITdataGet();
  //     if (result.result == Result.success) {
  //       state = SaveState.success;
  //       print("AUDIT 데이터 불러오기 완료");
  //     } else {
  //       state = SaveState.fail;
  //       print("AUDIT 데이터 불러오기 실패");
  //     }
  //   } catch (e) {
  //     print(e);
  //     state = SaveState.fail;
  //     print("AUDIT 데이터 불러오기 오류");
  //   }
  // }
}
