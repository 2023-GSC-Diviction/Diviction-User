import 'package:diviction_user/widget/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/style.dart';
import '../screen/day_check_screen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {required this.nickname,
      required this.path,
      this.onProfilePressed,
      super.key});

  final String nickname;
  final String? path;
  final onProfilePressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ProfileImage(
          onProfileImagePressed: () => onProfilePressed(context),
          isChoosedPicture: false,
          path: path,
          type: 1,
          imageSize: 40,
        ),
        const SizedBox(width: 10),
        GestureDetector(
            onTap: () => onProfilePressed(context),
            child: Text(nickname, style: TextStyles.chatNicknameTextStyle)),
      ]),
    );
  }
}
