import 'package:diviction_user/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAppbar extends StatelessWidget with PreferredSizeWidget {
  const MyAppbar(
      {required this.isMain, this.title, required this.hasBack, super.key});

  final bool isMain;
  final String? title;
  final bool hasBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: const Color.fromRGBO(255, 255, 255, 0.5),
      backgroundColor: Colors.transparent,
      leading: hasBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black45,
              ),
              onPressed: () => backDialog(context))
          : IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
      title: Center(
          child: Text(
        title ?? 'Diviction',
        style: TextStyle(color: Colors.black54),
      )),
      actions: isMain
          ? [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black54),
                onPressed: () {},
              ),
            ]
          : [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
      elevation: 0,
    );
  }
}
