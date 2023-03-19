import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// final chatProvider = StreamProvider((ref) => null)

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  bool isChoosedPicture = false;
  String newMessage = '';
  String path = '';
  final sendBoxSize = 40.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              children: [const Expanded(child: Messages()), sendMesssage()],
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
              onPressed: () {},
              icon: const Icon(Icons.upload_rounded),
              color: Colors.blue,
            ),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Send a message...',
          ),
          onChanged: (value) {
            newMessage = value;
          },
        ))
      ]));

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
