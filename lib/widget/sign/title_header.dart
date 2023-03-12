import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String titleContext;
  final String subContext;
  const TitleHeader({
    Key? key,
    required this.titleContext,
    required this.subContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleContext,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        if(subContext != '')
          SizedBox(height: size.height * 0.015),
        if(subContext != '')
          Text(
            subContext,
            style: TextStyle(color: Color(0xFF808080), fontSize: 18),
          ),
      ],
    );
  }
}
