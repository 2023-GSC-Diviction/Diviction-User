import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/model/chat.dart';
import 'package:diviction_user/model/counselor.dart';
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

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatroomId, this.counselor});

  final String chatroomId;
  final Counselor? counselor;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  bool isChoosedPicture = false;
  String newMessage = '';
  bool isSended = false;
  late String userId;
  String path = '';
  final sendBoxSize = 40.0;

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
            appBar: const MyAppbar(
              isMain: false,
              hasBack: false,
            ),
            extendBodyBehindAppBar: false,
            body: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                  stream: ChatService().getChatRoomData(widget.chatroomId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Messages(
                          messages: snapshot.data!.messages, userId: userId);
                    } else {
                      return const Center(
                        child: Text('sendMessage'),
                      );
                    }
                  },
                )),
                sendMesssage()
              ],
            )));
  }

  Widget sendMesssage() => Container(
      height: sendBoxSize + 20,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(18, 0, 0, 0), blurRadius: 10)
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onSendImagePressed,
          icon: const Icon(Icons.attach_file),
          color: Colors.blue,
          iconSize: 25,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextField(
          maxLines: null,
          style: TextStyle(color: Colors.black),
          controller: _controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: onSendMessage,
              icon: const Icon(Icons.upload_rounded),
              color: Colors.blue,
            ),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Send a message...',
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
        createdAt: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));

    if (widget.counselor != null && isSended == false) {
      setState(() {
        isSended = true;
      });

      newChatroom();
    }
    if (isSended) {
      ChatService().sendMessage(
        widget.chatroomId,
        message,
      );
    }
  }

  newChatroom() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('email')!;
    final username = prefs.getString('name')!;
    final message = Message(
        content: newMessage,
        sender: userId,
        createdAt: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()));
    final chatroom = ChatRoom(
        chatRoomId: widget.chatroomId,
        counselor: ChatMember(
            name: widget.counselor!.name,
            email: widget.counselor!.email,
            role: 'counselor'),
        user: ChatMember(name: username, email: userId, role: 'user'),
        messages: [message]);
    ChatService().newChatRoom(chatroom, message);
  }

  onSendImagePressed() async {
    final picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          isChoosedPicture = true;
          path = image.path;
        });
      }
      print(image);
    } catch (e) {
      print(e);
    }
  }
}
