import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/profile_screen.dart';
import 'package:diviction_user/screen/chat/chat_screen.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/service/chat_service.dart';
import 'package:diviction_user/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/style.dart';
import '../../model/chat.dart';
import 'chat_time_format.dart';

class ChatList extends StatelessWidget {
  const ChatList({this.chats, super.key});

  final List<MyChat>? chats;

  @override
  Widget build(BuildContext context) {
    onProfilePressed(BuildContext context, String counselorEmail) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    email: counselorEmail,
                  )));
    }

    void toChatroom(String chatroomId, Counselor counselor) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    chatroomId: chatroomId,
                    isNew: false,
                    counselor: counselor,
                  )));
    }

    onButtonPressed(String counselorEmail) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userEmail = prefs.getString('email')!;
      String chatroomId = ('$counselorEmail&$userEmail').replaceAll('.', '');

      final counselor = await AuthService().getUser(counselorEmail);

      toChatroom(chatroomId, counselor);
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: chats!.length,
        padding: const EdgeInsets.only(bottom: 40),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => onButtonPressed(
                    chats!.elementAt(index).otherEmail,
                  ),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(children: [
                          GestureDetector(
                            onTap: () => onProfilePressed(
                                context, chats!.elementAt(index).otherEmail),
                            child: ProfileImage(
                              onProfileImagePressed: () => onProfilePressed(
                                  context, chats!.elementAt(index).otherEmail),
                              isChoosedPicture: false,
                              path: null,
                              type: 1,
                              imageSize: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(chats![index].otherName,
                                  style: TextStyles.chatHeading),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(chats![index].lastMessage,
                                  style: TextStyles.chatbodyText),
                            ],
                          ),
                        ]),
                        Text(dataTimeFormat(chats![index].lastTime),
                            style: TextStyles.chatbodyText),
                      ])));
        });
  }
}
