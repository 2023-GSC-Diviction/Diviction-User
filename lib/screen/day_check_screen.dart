import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DayCheckScreen extends StatelessWidget {
  const DayCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            '어제는 잘 참으셨나요?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: InkWell(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(20),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Text('No 😂',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))))),
                    Flexible(
                        flex: 1,
                        child: InkWell(
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(20),
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                child: Text('Yes 😁',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)))))
                  ],
                )))
      ],
    );
  }
}
