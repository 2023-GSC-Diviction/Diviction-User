import 'package:diviction_user/service/chat_service.dart';
import 'package:diviction_user/service/counselor_service.dart';
import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';

final counselorListProvider =
    StreamProvider.autoDispose((ref) => ChatService().getChatListData());

class RequestedCounselorScreen extends ConsumerStatefulWidget {
  const RequestedCounselorScreen({super.key});

  @override
  RequestedCounselorScreenState createState() =>
      RequestedCounselorScreenState();
}

class RequestedCounselorScreenState
    extends ConsumerState<RequestedCounselorScreen> {
  @override
  Widget build(BuildContext context) {
    final chatList = ref.watch(counselorListProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Chat', style: TextStyles.titleTextStyle),
          const SizedBox(height: 20),
          chatList.when(
              data: (item) => item.isEmpty
                  ? const Center(child: Text('empty'))
                  : Expanded(
                      child: CounselorList(
                      chats: item,
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
