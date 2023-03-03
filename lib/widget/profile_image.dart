// import 'dart:io';

// import 'package:flutter/material.dart';

// class ProfileImage extends StatefulWidget {
//   final path;
//   final double imageSize;

//   const ProfileImage({
//     Key? key,
//     required this.path,
//     required this.imageSize,
//   }) : super(key: key);

//   @override
//   State<ProfileImage> createState() => _ProfileImageState();
// }

// class _ProfileImageState extends State<ProfileImage> {
//   @override
//   Widget build(BuildContext context) {
//     return ClipOval(
//         child: Container(
//             width: widget.imageSize,
//             height: widget.imageSize,
//             alignment: Alignment.center,
//             decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 image: DecorationImage(
//                     image: AssetImage('assets/icons/psychological_icon.png'),
//                     fit: BoxFit.cover))));
//   }

//   Widget choosedImage() {
//     return Image.file(
//       File(widget.path),
//       width: widget.imageSize,
//       height: widget.imageSize,
//       fit: BoxFit.cover,
//     );
//   }

//   Widget defaultImage() {
//     return Image.asset(
//       'assets/icons/psychological_icon.png',
//       width: widget.imageSize,
//       height: widget.imageSize,
//       fit: BoxFit.cover,
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final onProfileImagePressed;
  final isChoosedPicture;
  final path;
  final int type;
  final double imageSize;

  const ProfileImage({
    Key? key,
    required this.onProfileImagePressed,
    required this.isChoosedPicture,
    required this.path,
    required this.type,
    required this.imageSize,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        padding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        onPressed: widget.onProfileImagePressed,
        // ClipOval : 아래 자식의 UI를 동그랗게 만들어주는 위젯
        icon: (() {
          if (widget.isChoosedPicture) {
            return ClipOval(child: choosedImage());
          } else {
            return ClipOval(child: defaultImage());
          }
        })(),
        // 이미지 크기는 iconSize에서 조절함
        iconSize: widget.imageSize,
      ),
      widget.type == 0
          ? Positioned(
              // Positioned : 위치 정렬에 쓰임. 아래는 오른쪽 아래로 부터 0.01만큼 떨어지게 배치하라는 코드
              right: MediaQuery.of(context).size.height * 0.01,
              bottom: MediaQuery.of(context).size.height * 0.01,
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.025,
                height: MediaQuery.of(context).size.height * 0.025,
                child: Image.asset('assets/icons/psychological_icon.png',
                    fit: BoxFit.fill),
              ),
            )
          : SizedBox()
    ]);
  }

  Widget choosedImage() {
    return Image.file(
      File(widget.path),
      width: widget.imageSize,
      height: widget.imageSize,
      fit: BoxFit.cover,
    );
  }

  Widget defaultImage() {
    return Image.asset(
      'assets/icons/psychological_icon.png',
      width: widget.imageSize,
      height: widget.imageSize,
      fit: BoxFit.cover,
    );
  }
}