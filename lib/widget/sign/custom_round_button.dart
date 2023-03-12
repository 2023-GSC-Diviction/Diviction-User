import 'package:flutter/material.dart';

class CustomRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomRoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF787878),
              padding: EdgeInsets.symmetric(vertical: 20), // 버튼 위아래 패딩 조절
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(49), // 모서리 둥글게
              ),
            ),
          ),
        ),
      ],
    );
  }
}
