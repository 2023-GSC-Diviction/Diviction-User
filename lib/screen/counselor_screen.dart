import 'package:diviction_user/screen/counselor_requested_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CounselorScreen extends StatefulWidget {
  const CounselorScreen({super.key});

  @override
  State<CounselorScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<CounselorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

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
            optionButton(),
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
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide:
                  BorderSide(width: 1, color: Color.fromARGB(67, 28, 28, 28))),
          contentPadding: EdgeInsets.all(0),
          hintText: '#태그',
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Color.fromARGB(67, 28, 28, 28)),
              borderRadius: BorderRadius.circular(40)),
          prefixIcon: Padding(
              padding: EdgeInsets.only(left: 13), child: Icon(Icons.search))),
    );
  }

  Widget optionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side:
                    BorderSide(width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            onPressed: () {
              optionSheet(0);
            },
            child: Row(
              children: [
                Text('종류', style: TextStyle(color: Colors.black87)),
                Icon(Icons.arrow_drop_down, color: Colors.black87)
              ],
            )),
        SizedBox(
          width: 10,
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side:
                    BorderSide(width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            onPressed: () {
              optionSheet(1);
            },
            child: Row(
              children: [
                Text('지역', style: TextStyle(color: Colors.black87)),
                Icon(Icons.arrow_drop_down, color: Colors.black87)
              ],
            ))
      ],
    );
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
            padding: EdgeInsets.only(bottom: 40, top: 20),
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

  Widget bottomBar() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CounselorRequestedScreen()));
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  horizontal:
                      BorderSide(width: 1, color: Color.fromARGB(10, 0, 0, 0))),
            ),
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text('내가 한 요청 보기',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontWeight: FontWeight.w600)),
                Icon(Icons.arrow_right_sharp)
              ],
            )));
  }

  void optionSheet(int option) {
    _tabController.index = option;
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (BuildContext context) => optionWidget());
  }

  Widget optionWidget() {
    List<String> regions = [
      '전국',
      '서울',
      '세종',
      '강원',
      '인천',
      '경기',
      '충북',
      '충남',
      '경북',
      '대전',
      '대구',
      '전북',
      '경남'
    ];
    List<String> drugTypes = ['코카인', '펜타닐', '헤로인'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 10),
          width: 130,
          child: TabBar(
              tabs: const [
                Tab(
                  text: '종류',
                ),
                Tab(
                  text: '지역',
                )
              ],
              onTap: (value) => _tabController.animateTo(value),
              controller: _tabController,
              labelColor: Colors.blue[300],
              unselectedLabelColor: Colors.black54,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        ),
        SizedBox(
            height: 600,
            child: TabBarView(controller: _tabController, children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: drugTypes.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border.lerp(
                              const Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                              ),
                              null,
                              0.4),
                        ), //
                        margin: EdgeInsets.only(bottom: 13),
                        padding: EdgeInsets.only(bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              drugTypes[index],
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ));
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: regions.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border.lerp(
                              const Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.black12,
                                ),
                              ),
                              null,
                              0.4),
                        ), //
                        margin: EdgeInsets.only(bottom: 13),
                        padding: EdgeInsets.only(bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              regions[index],
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(Icons.arrow_drop_down_outlined)
                          ],
                        ));
                  }),
            ])),
      ],
    );
  }
}
