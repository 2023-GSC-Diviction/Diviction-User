import 'package:flutter/material.dart';

class PreOrNextButton extends StatelessWidget {
  final String content;
  final IconData? icondata;
  final VoidCallback onPressed;

  const PreOrNextButton({
    Key? key,
    required this.content,
    required this.icondata,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: content == 'Back'
              ? [
            Icon(icondata),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text(
              content,
              style: const TextStyle(fontSize: 20),
            ),
          ]
              : [
            Text(
              content,
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Icon(icondata),
          ],
        ),
      ),
    );
  }
}
