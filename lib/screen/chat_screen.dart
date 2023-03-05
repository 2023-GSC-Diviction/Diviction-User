import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  bool isChoosedPicture = false;
  String path = '';
  final sendBoxSize = 55.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppbar(
          isMain: false,
          hasBack: false,
        ),
        extendBodyBehindAppBar: false,
        body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [const Expanded(child: Messages()), sendMesssage()],
            )));
  }

  Widget sendMesssage() {
    return Container(
      height: sendBoxSize,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: sendBoxSize,
            height: sendBoxSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: onSendImagePressed,
              icon: const Icon(Icons.attach_file),
              color: Colors.white,
              iconSize: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                ),
                labelText: 'Send a message...',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue)),
              ),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
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
