import 'package:diviction_user/widget/chat/messages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatProvider extends StateNotifier {
  ChatProvider() : super(0);

  // @riverpod
  Stream<List<Messages>> chat() async* {}
}
