import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAppbar extends StatelessWidget with PreferredSizeWidget {
  const MyAppbar({required this.isMain, super.key});

  final bool isMain;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: const Color.fromRGBO(255, 255, 255, 0.5),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: const Center(
          child: Text(
        'Diviction',
        style: TextStyle(color: Colors.black54),
      )),
      actions: isMain
          ? [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black54),
                onPressed: () {},
              ),
            ]
          : [],
      elevation: 0,
    );
  }
}
