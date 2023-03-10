import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../../model/counselor.dart';

final counselorListProvider = FutureProvider<List<Counselor>>((ref) async {
  return await CounselorService().getCounselorsByOption({'drug': 'alcohol'});
});

class RequestedCounselorScreen extends ConsumerWidget {
  const RequestedCounselorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counselorList = ref.watch(counselorListProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Chat', style: TextStyles.titleTextStyle),
          counselorList.when(
              data: (item) => Expanded(
                      child: CounselorList(
                    counselorList: item,
                    requested: true,
                  )),
              error: (e, st) =>
                  Expanded(child: Center(child: Text('Error: $e'))),
              loading: () => const Expanded(
                  child: Center(child: CircularProgressIndicator())))
        ],
      ),
    );
  }
}
