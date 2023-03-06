import 'package:diviction_user/widget/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/style.dart';
import '../screen/day_check_screen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({required this.nickname, required this.id, super.key});

  final id;
  final nickname;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        ProfileImage(
          onProfileImagePressed: () => {onProfilePressed(context)},
          isChoosedPicture: false,
          path: null,
          type: 1,
          imageSize: 25,
        ),
        GestureDetector(
            onTap: () => onProfilePressed(context),
            child: Text(nickname, style: TextStyles.chatNicknameTextStyle)),
      ]),
    );
  }

  onProfilePressed(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DayCheckScreen()));
  }
}
