import 'package:diviction_user/model/chat.dart';
import 'package:diviction_user/widget/chat/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages(
      {super.key,
      required this.messages,
      required this.userId,
      required this.counselorName});

  final List<Message> messages;
  final String userId;
  final String counselorName;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return ChatBubbles(messages[index].content,
                messages[index].sender == userId, counselorName);
          },
        ));
  }
}
