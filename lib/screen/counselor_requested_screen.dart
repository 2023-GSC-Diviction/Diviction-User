import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../config/style.dart';

class CounselorRequestedScreen extends StatefulWidget {
  const CounselorRequestedScreen({super.key});

  @override
  State<CounselorRequestedScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<CounselorRequestedScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> counselorList = [
      '수딩',
      '혜진',
      '우중',
      '주원',
      '태영',
      '수딩',
      '혜진',
      '우중',
      '주원',
      '태영'
    ];
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('보낸 요청', style: TextStyles.titleTextStyle),
              ),
              Expanded(child: CounselorList(counselorList: counselorList))
            ],
          ),
        ));
  }
}
