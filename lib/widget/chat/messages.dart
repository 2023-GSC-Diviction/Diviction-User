import 'package:diviction_user/model/chat.dart';
import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/widget/chat/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages(
      {super.key,
      required this.messages,
      required this.userId,
      required this.counselor});

  final List<Message> messages;
  final String userId;
  final Counselor counselor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ChatBubbles(
                messages[index], messages[index].sender == userId, counselor);
          },
        ));
  }
}
