import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CounselorRequestedScreen extends StatefulWidget {
  const CounselorRequestedScreen({super.key});

  @override
  State<CounselorRequestedScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<CounselorRequestedScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: Text('보낸 요청',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.w800)),
              ),
              counselorList()
            ],
          ),
        ));
  }

  Widget counselorList() {
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
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: counselorList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(10),
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
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(51, 51, 51, 1),
                                fontWeight: FontWeight.w800),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '@@상담센터',
                                  style: const TextStyle(
                                    letterSpacing: 0.04,
                                    fontSize: 14,
                                    color: Color.fromRGBO(82, 82, 82, 0.644),
                                  ))
                            ]),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ));
            }));
  }
}
