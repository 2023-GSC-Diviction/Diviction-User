import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounselorProvider extends StateNotifier<List<Counselor>> {
  CounselorProvider() : super(<Counselor>[]);

  final CounselorService _counselorService = CounselorService();

  @override
  set state(List<Counselor> value) {
    super.state = value;
  }

  void searchCounselor(String option) {
    _counselorService.getCounselorsByOption(option).then((value) {
      state = value;
    }).catchError((onError) => state = <Counselor>[]);
  }
}
