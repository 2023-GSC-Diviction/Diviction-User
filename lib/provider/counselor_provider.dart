import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounselorProvider extends StateNotifier<List<Counselor>> {
  CounselorProvider() : super(<Counselor>[]);

  final CounselorService _counselorService = CounselorService();
  Map<String, String> _options = {};

  @override
  set state(List<Counselor> value) {
    super.state = value;
  }

  void getCounselor() {
    _counselorService.getCounselorsByOption(_options).then((value) {
      state = value;
    }).catchError((onError) => null);
  }

  void addOption(String type, String option) {
    _options[type] = option;
    _counselorService.getCounselorsByOption(_options).then((value) {
      state = value;
    }).catchError((onError) => null);
  }
}
