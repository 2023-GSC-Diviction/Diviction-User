import 'package:diviction_user/screen/chat_screen.dart';
import 'package:diviction_user/widget/profile_image.dart';
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Palette.borderColor)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => CounselorDetailScreen()));
                    },
                    child: Row(
                      children: [
                        ProfileImage(
                          onProfileImagePressed: () {},
                          isChoosedPicture: false,
                          path: null,
                          type: 1,
                          imageSize: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text.rich(
                          TextSpan(
                              text: '${counselorList[index]}님\n',
                              style: TextStyles.mainTextStyle,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: '@@상담센터',
                                    style: TextStyles.shadowTextStyle),
                              ]),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text('문의하기',
                              style: TextStyles.blueBottonTextStyle),
                        ),
                      ))
                ],
              ));
        });
  }
}
