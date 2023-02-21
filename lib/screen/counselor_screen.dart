import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CounselorScreen extends StatefulWidget {
  const CounselorScreen({super.key});

  @override
  State<CounselorScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<CounselorScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('상담사 찾기',
                  style: TextStyle(
                      fontSize: 22,
                      color: Color.fromRGBO(51, 51, 51, 1),
                      fontWeight: FontWeight.w800)),
            ),
            searchBar(),
            counselorList()
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: bottomBar(),
      )
    ]);
  }

  Widget searchBar() {
    return TextField(
      decoration: InputDecoration(
          hintText: '#태그 기반',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          prefixIcon: Padding(
              padding: EdgeInsets.only(left: 13), child: Icon(Icons.search))),
    );
  }

  Widget counselorList() {
    List<String> counselorList = ['수딩', '혜진', '우중', '주원', '태영'];
    return ListView.builder(
        shrinkWrap: true,
        itemCount: counselorList.length,
        padding: EdgeInsets.symmetric(vertical: 10),
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
        });
  }

  Widget bottomBar() {
    return InkWell(
        onTap: routeDialog,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Container(
                padding: const EdgeInsets.all(12),
                child: const Text(
                  '내가 한 요청 보기',
                ))));
  }

  void routeDialog() => showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      builder: (BuildContext context) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(24, 38, 24, 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('내가 한 요청')]))
            ],
          ));
}
