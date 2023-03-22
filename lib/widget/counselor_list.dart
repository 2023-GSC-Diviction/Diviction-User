import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/chat/chat_screen.dart';
import 'package:diviction_user/screen/profile_screen.dart';
import 'package:diviction_user/service/chat_service.dart';
import 'package:diviction_user/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/style.dart';
import '../model/chat.dart';

class CounselorList extends StatelessWidget {
  const CounselorList({this.counselor, super.key});

  final List<Counselor>? counselor;

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
                  chatroomId: chatroomId, isNew: false, counselor: counselor)));
    }

    void toNewChatroom(String chatroomId, Counselor counselor) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    chatroomId: chatroomId,
                    counselor: counselor,
                    isNew: true,
                  )));
    }

    onButtonPressed(String counselorEmail, Counselor counselor) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userEmail = prefs.getString('email')!;
      String chatroomId = ('$counselorEmail&$userEmail').replaceAll('.', '');

      final chatList = await ChatService().getChatList();
      bool isExist = chatList
          .map(
            (e) => e.chatRoomId,
          )
          .toList()
          .contains(chatroomId);
      if (isExist) {
        toChatroom(chatroomId, counselor);
      } else {
        toNewChatroom(chatroomId, counselor);
      }
    }

    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 40, top: 20),
        itemCount: counselor!.length,
        itemBuilder: (context, index) {
          return Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Palette.borderColor)),
              margin: const EdgeInsets.only(bottom: 30),
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
                          imageSize: 60,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text.rich(
                          TextSpan(
                              text: '${counselor![index].name}\n',
                              style: TextStyles.chatHeading,
                              children: <TextSpan>[
                                TextSpan(
                                    text: counselor!.elementAt(index).address,
                                    style: TextStyles.chatbodyText),
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
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          color: Palette.appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('request consult',
                              style: TextStyles.blueBottonTextStyle),
                        ),
                      ))
                ],
              ));
        });
  }
}
