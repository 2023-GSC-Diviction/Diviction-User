import 'package:diviction_user/widget/chat/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return ChatBubbles('', true, '');
      },
    );
  }
}
