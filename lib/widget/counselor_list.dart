import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/chat/chat_screen.dart';
import 'package:diviction_user/screen/counselor/counselor_screen.dart';
import 'package:diviction_user/screen/profile/counselor_profile_screen.dart';
import 'package:diviction_user/screen/profile/user_profile_screen.dart';
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
    onProfilePressed(BuildContext context, Counselor counselor) async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CounselorProfileScreen(
                    counselor: counselor,
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
                    onTap: () =>
                        onProfilePressed(context, counselor!.elementAt(index)),
                    child: Row(
                      children: [
                        ProfileImage(
                          onProfileImagePressed: () => onProfilePressed(
                              context, counselor!.elementAt(index)),
                          isChoosedPicture: false,
                          path: counselor!.elementAt(index).profileUrl,
                          type: 1,
                          imageSize: MediaQuery.of(context).size.width * 0.12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text.rich(
                              TextSpan(
                                  text: '${counselor![index].name}\n',
                                  style: TextStyles.chatHeading,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            counselor!.elementAt(index).address,
                                        style: TextStyles.chatbodyText),
                                  ]),
                              textAlign: TextAlign.start,
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () => onButtonPressed(
                          counselor!.elementAt(index).email,
                          counselor!.elementAt(index)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.24,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          color: Palette.appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('request',
                              style: TextStyles.blueBottonTextStyle),
                        ),
                      ))
                ],
              ));
        });
  }
}
