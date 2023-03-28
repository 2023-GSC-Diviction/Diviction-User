import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAppbar extends StatelessWidget with PreferredSizeWidget {
  const MyAppbar(
      {required this.isMain,
      this.title,
      required this.hasBack,
      this.hasDialog,
      super.key});

  final bool isMain;
  final String? title;
  final bool hasBack;
  final bool? hasDialog;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: const Color.fromRGBO(255, 255, 255, 0.5),
      backgroundColor: Palette.appColor4,
      leading: hasBack
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black45,
              ),
              onPressed: () => hasDialog != null && hasDialog == false
                  ? Navigator.pop(context)
                  : backDialog(context))
          : Container(),
      title: Center(
          child: Text(
        title ?? 'Diviction',
        style: TextStyle(color: Colors.white, fontSize: 20),
      )),
      actions: isMain
          ? [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ]
          : [
              IconButton(
                icon:
                    const Icon(Icons.notifications, color: Colors.transparent),
                onPressed: () {},
              ),
            ],
      elevation: 0,
    );
  }
}
