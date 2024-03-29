import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/model/chat.dart';
import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/screen/profile/counselor_profile_screen.dart';
import 'package:diviction_user/service/auth_service.dart';
import 'package:diviction_user/service/chat_service.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/image_picker_service.dart';
import '../../widget/profile_image.dart';
import '../profile/user_profile_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.chatroomId,
      required this.isNew,
      required this.counselor});

  final String chatroomId;
  final Counselor counselor;
  final bool isNew;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  bool isChoosedPicture = false;
  String newMessage = '';
  bool isSended = false;
  late String userId;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('email')!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 닫기 이벤트
        },
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.12,
              backgroundColor: Color.fromARGB(255, 42, 42, 42),
              title: GestureDetector(
                onTap: () => onProfilePressed(context, widget.counselor),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ProfileImage(
                            onProfileImagePressed: () =>
                                onProfilePressed(context, widget.counselor),
                            isChoosedPicture: false,
                            path: widget.counselor.profileUrl,
                            type: 1,
                            imageSize:
                                MediaQuery.of(context).size.height * 0.07,
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.counselor.name,
                                    style: const TextStyle(
                                        color: Palette.appColor,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.counselor.address,
                                    style: const TextStyle(
                                        color: Palette.appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.arrow_right,
                            color: Palette.appColor,
                          ),
                          // Text('go to request',
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 15,
                          //         fontWeight: FontWeight.w400)),
                        ],
                      )
                    ]),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: Color.fromARGB(255, 42, 42, 42),
            extendBodyBehindAppBar: false,
            body: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Palette.appColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: StreamBuilder(
                          stream:
                              ChatService().getChatRoomData(widget.chatroomId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Messages(
                                  messages:
                                      snapshot.data!.messages.reversed.toList(),
                                  userId: userId,
                                  counselor: widget.counselor);
                            } else {
                              return const Center(
                                child: Text('sendMessage'),
                              );
                            }
                          },
                        )),
                        sendMesssage()
                      ],
                    ))
              ],
            )));
  }

  Widget sendMesssage() => Container(
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(18, 0, 0, 0), blurRadius: 10)
        ],
        color: Palette.appColor,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onSendImagePressed,
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          iconSize: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: onSendMessage,
              icon: const Icon(Icons.send),
              color: Colors.blue,
              iconSize: 25,
            ),
            hintText: "Type your message here",
            hintMaxLines: 1,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            hintStyle: const TextStyle(
              fontSize: 16,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 0.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                color: Colors.black26,
                width: 0.2,
              ),
            ),
          ),
          onChanged: (value) {
            newMessage = value;
          },
        )),
      ]));

  onSendMessage() {
    final Message message = Message(
        content: newMessage,
        sender: userId,
        createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

    if (widget.isNew && !isSended) {
      setState(() {
        isSended = true;
      });

      newChatroom();
    } else {
      ChatService().sendMessage(
        widget.chatroomId,
        message,
      );
    }
    _controller.text = '';
    FocusScope.of(context).unfocus();
  }

  newChatroom() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('email')!;
    final username = prefs.getString('name')!;
    final userUrl = prefs.getString('profile_img_url')!;
    final message = Message(
        content: newMessage,
        sender: userId,
        createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    final chatroom = ChatRoom(
        chatRoomId: widget.chatroomId,
        counselor: ChatMember(
            name: widget.counselor.name,
            email: widget.counselor.email,
            photoUrl: widget.counselor.profileUrl,
            role: 'counselor'),
        user: ChatMember(
            name: username, email: userId, role: 'user', photoUrl: userUrl),
        messages: [message]);
    ChatService().newChatRoom(chatroom, message);
  }

  onSendImagePressed() async {
    try {
      final image = await ImagePickerService().pickSingleImage();
      if (image != null) {
        setState(() {
          isChoosedPicture = true;
        });
        final message = Message(
            content: 'image@${image.path}',
            sender: userId,
            createdAt:
                DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));
        ChatService().sendImage(widget.chatroomId, image, message);
      }
      print(image);
    } catch (e) {
      print(e);
    }
  }

  onProfilePressed(BuildContext context, Counselor counselor) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CounselorProfileScreen(
                  counselor: counselor,
                )));
  }
}
