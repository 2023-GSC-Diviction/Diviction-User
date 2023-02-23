import 'package:diviction_user/widget/chat/chat_bubble.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Column(children: [
          ChatBubbles('hello', true, 'herry'),
          ChatBubbles('hello!!', false, 'herry'),
          ChatBubbles('how are you!!', true, 'herry'),
          ChatBubbles('good!! what\' your name?', false, 'herry'),
          ChatBubbles('my name is jinni', true, 'herry'),
        ]));
    // ])
    // ,ListView.builder(
    //   reverse: true,
    //   itemCount: 5,
    //   itemBuilder: (context, index) {
    //     return ChatBubbles('', true, '');
    //   },
    // );
  }
}
