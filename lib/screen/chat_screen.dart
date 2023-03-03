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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(
          isMain: false,
        ),
        extendBodyBehindAppBar: false,
        body: Container(
          child: Column(
            children: [
              topBar(),
              const Expanded(child: Messages()),
              sendMesssage()
            ],
          ),
        ));
  }

  Widget topBar() {
    return Container(
      color: Colors.blue[100],
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Text(
            '@@@ 상담사님',
            style: TextStyles.mainTextStyle,
          )
        ],
      ),
    );
  }

  Widget sendMesssage() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 10),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: onProfileImagePressed,
            icon: const Icon(Icons.attach_file),
            color: Colors.blue,
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

  onProfileImagePressed() async {
    print("onProfileImagePressed 실행완료");

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
