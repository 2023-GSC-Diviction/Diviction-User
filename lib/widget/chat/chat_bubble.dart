import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/model/chat.dart';
import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/profile/counselor_profile_screen.dart';
import 'package:diviction_user/screen/day_check_screen.dart';
import 'package:diviction_user/screen/profile/user_profile_screen.dart';
import 'package:diviction_user/widget/chat/chat_time_format.dart';
import 'package:diviction_user/widget/profile_button.dart';
import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.counselor, {Key? key})
      : super(key: key);

  final Message message;
  final Counselor counselor;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe)
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(dataTimeFormat(message.createdAt),
                      style: TextStyles.shadowTextStyle),
                  BubbleSpecialOne(
                      text: message.content,
                      isSender: true,
                      color: Palette.appColor,
                      textStyle: TextStyles.blueBottonTextStyle),
                ])),
          if (!isMe)
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileButton(
                          nickname: counselor.name,
                          path: counselor.profileUrl,
                          onProfilePressed: onProfilePressed),
                      Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BubbleSpecialOne(
                                  text: message.content,
                                  isSender: false,
                                  color: Palette.chatGrayColor,
                                  textStyle:
                                      TextStyles.chatNotMeBubbleTextStyle,
                                ),
                                Text(dataTimeFormat(message.createdAt),
                                    style: TextStyles.shadowTextStyle),
                              ]))
                    ]))
        ]);
  }

  onProfilePressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CounselorProfileScreen(
                  counselor: counselor,
                )));
  }
}
