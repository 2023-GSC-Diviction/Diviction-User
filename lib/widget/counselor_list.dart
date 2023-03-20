import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/chat_screen.dart';
import 'package:diviction_user/screen/day_check_screen.dart';
import 'package:diviction_user/screen/profile_screen.dart';
import 'package:diviction_user/service/chat_service.dart';
import 'package:diviction_user/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/style.dart';
import '../model/chat.dart';

class CounselorList extends StatelessWidget {
  const CounselorList({this.chats, this.counselor, super.key});

  final List<Counselor>? counselor;
  final List<MyChat>? chats;

  @override
  Widget build(BuildContext context) {
    onProfilePressed(BuildContext context, String counselorEmail) async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileScreen()));
    }

    void toChatroom(String chatroomId) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(chatroomId: chatroomId)));
    }

    void toNewChatroom(String chatroomId, Counselor counselor) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(chatroomId: chatroomId, counselor: counselor)));
    }

    onButtonPressed(String counselorEmail, Counselor? counselor) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userEmail = prefs.getString('email')!;
      String chatroomId = (counselorEmail + userEmail).replaceAll('.', '');
      if (counselor == null) {
        toChatroom(chatroomId);
      } else {
        final chatList = await ChatService().getChatList();
        bool isExist = chatList
            .map(
              (e) => e.chatRoomId,
            )
            .toList()
            .contains(chatroomId);
        if (isExist) {
          toChatroom(chatroomId);
        } else {
          toNewChatroom(chatroomId, counselor);
        }
      }
    }

    return counselor == null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: chats!.length,
            padding: const EdgeInsets.only(bottom: 40),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () =>
                      onButtonPressed(chats!.elementAt(index).otherEmail, null),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.borderColor)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => onProfilePressed(
                                context, chats!.elementAt(index).otherEmail),
                            child: Row(children: [
                              ProfileImage(
                                onProfileImagePressed: () => onProfilePressed(
                                    context,
                                    chats!.elementAt(index).otherEmail),
                                isChoosedPicture: false,
                                path: null,
                                type: 1,
                                imageSize: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                    text: '${chats![index].otherName}\n',
                                    style: TextStyles.mainTextStyle,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: chats!
                                              .elementAt(index)
                                              .lastMessage,
                                          style: TextStyles.shadowTextStyle),
                                    ]),
                              )
                            ])),
                      ],
                    ),
                  ));
            })
        : ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 40),
            itemCount: counselor!.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Palette.borderColor)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => onProfilePressed(
                            context, counselor!.elementAt(index).email),
                        child: Row(
                          children: [
                            ProfileImage(
                              onProfileImagePressed: () => onProfilePressed(
                                  context, counselor!.elementAt(index).email),
                              isChoosedPicture: false,
                              path: null,
                              type: 1,
                              imageSize: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: '${counselor![index].name}\n',
                                  style: TextStyles.mainTextStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            counselor!.elementAt(index).address,
                                        style: TextStyles.shadowTextStyle),
                                  ]),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () => onButtonPressed(
                              counselor!.elementAt(index).email,
                              counselor!.elementAt(index)),
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('consult',
                                  style: TextStyles.blueBottonTextStyle),
                            ),
                          ))
                    ],
                  ));
            });
  }
}
