import 'package:flutter/material.dart';
import '../config/style.dart';

class CounselorList extends StatelessWidget {
  const CounselorList({required this.counselorList, super.key});

  final List<String> counselorList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: counselorList.length,
        padding: const EdgeInsets.only(bottom: 40, top: 20),
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text.rich(
                    TextSpan(
                        text: '${counselorList[index]}님\n',
                        style: TextStyles.mainTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text: '@@상담센터',
                              style: TextStyles.shadowTextStyle),
                        ]),
                    textAlign: TextAlign.start,
                  ),
                ],
              ));
        });
  }
}
