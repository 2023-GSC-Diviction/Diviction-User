import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/screen/day_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../profile_image.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userName, {Key? key})
      : super(key: key);

  final String message;
  final String userName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ChatBubble(
              clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: Colors.blue,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  message,
                  style: TextStyles.blueBottonTextStyle,
                ),
              ),
            ),
          ),
        if (!isMe)
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ProfileImage(
              onProfileImagePressed: () => onProfilePressed(context),
              isChoosedPicture: false,
              path: null,
              type: 1,
              imageSize: 30,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: () => onProfilePressed(context),
                  child:
                      Text(userName, style: TextStyles.chatNicknameTextStyle)),
              ChatBubble(
                clipper: ChatBubbleClipper8(type: BubbleType.receiverBubble),
                backGroundColor: Palette.chatGrayColor,
                margin: const EdgeInsets.only(top: 10),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyles.chatNotMeBubbleTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ]),
      ],
    );
  }

  onProfilePressed(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DayCheckScreen()));
  }
}
