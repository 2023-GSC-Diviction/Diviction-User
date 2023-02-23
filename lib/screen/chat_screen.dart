import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/widget/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [topBar(), Expanded(child: Messages()), sendMesssage()],
      ),
    );
  }

  Widget topBar() {
    return Container(
      color: Colors.blue[100],
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            '@@@ 상담사님',
            style: TextStyles.mainTextStyle,
          )
        ],
      ),
    );
  }

  Widget sendMesssage() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                ),
                labelText: 'Send a message...',
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue)),
              ),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
