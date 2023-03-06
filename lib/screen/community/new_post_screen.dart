import 'package:diviction_user/widget/appbar.dart';
import 'package:diviction_user/widget/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../config/style.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldController = TextEditingController();
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
        },
        child: Scaffold(
          appBar:
              const MyAppbar(isMain: false, hasBack: true, title: 'New Post'),
          body: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 20, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const ProfileButton(
                        nickname: 'nickname',
                        id: 'id',
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200]),
                        child: TextField(
                            controller: textFieldController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            maxLength: 1000,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.all(16),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusColor: Colors.transparent,
                              hintText: 'What is your problem?',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 14.0,
                              ),
                            )),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyles.dialogConfirmTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              )),
        ));
  }
}