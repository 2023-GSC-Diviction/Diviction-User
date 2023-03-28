import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final onProfileImagePressed;
  final isChoosedPicture;
  final String? path;
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
      GestureDetector(
          onTap: widget.onProfileImagePressed,
          child: Container(
            width: widget.imageSize,
            height: widget.imageSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: widget.path != null
                      ? NetworkImage(
                          widget.path!,
                        )
                      : const AssetImage('assets/icons/counselor.png')
                          as ImageProvider,
                  fit: BoxFit.cover),
            ),
          )),
      widget.type == 0
          ? Positioned(
              // Positioned : 위치 정렬에 쓰임. 아래는 오른쪽 아래로 부터 0.01만큼 떨어지게 배치하라는 코드
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                width: MediaQuery.of(context).size.height * 0.045,
                height: MediaQuery.of(context).size.height * 0.045,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 23,
                ),
              ),
            )
          : const SizedBox()
    ]);
  }
}
