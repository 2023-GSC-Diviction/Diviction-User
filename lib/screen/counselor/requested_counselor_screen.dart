import 'package:diviction_user/widget/counselor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../config/style.dart';

class RequestedCounselorScreen extends StatefulWidget {
  const RequestedCounselorScreen({super.key});

  @override
  State<RequestedCounselorScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<RequestedCounselorScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> counselorList = [
      'Michael',
      'David',
      'William',
      'Anthony',
      'Donald',
      'Brian',
      'Edward',
      'Christopher',
      'Kenneth',
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('보낸 요청', style: TextStyles.titleTextStyle),
          Expanded(
              child: CounselorList(
            counselorList: counselorList,
            requested: true,
          ))
        ],
      ),
    );
  }
}
