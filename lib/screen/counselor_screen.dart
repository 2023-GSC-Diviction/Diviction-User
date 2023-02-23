import 'package:diviction_user/screen/counselor_requested_screen.dart';
import 'package:diviction_user/widget/style.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('상담사 찾기',
                  style: Theme.of(context).textTheme.titleTextStyle),
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
              borderSide: const BorderSide(
                  width: 1, color: Color.fromARGB(67, 28, 28, 28))),
          contentPadding: const EdgeInsets.all(0),
          hintText: '#태그',
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Color.fromARGB(67, 28, 28, 28)),
              borderRadius: BorderRadius.circular(40)),
          prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 13), child: Icon(Icons.search))),
    );
  }

  Widget optionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            onPressed: () {
              optionSheet(0);
            },
            child: Row(
              children: const [
                Text('종류', style: TextStyle(color: Colors.black87)),
                Icon(Icons.arrow_drop_down, color: Colors.black87)
              ],
            )),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(67, 28, 28, 28)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            onPressed: () {
              optionSheet(1);
            },
            child: Row(
              children: const [
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
            padding: const EdgeInsets.only(bottom: 40, top: 20),
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.all(10),
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
                            style: Theme.of(context).textTheme.mainTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '@@상담센터',
                                  style: Theme.of(context)
                                      .textTheme
                                      .shadowTextStyle),
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
                  builder: (context) => const CounselorRequestedScreen()));
        },
        child: Container(
            decoration: const BoxDecoration(
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
              children: [
                Text('내가 한 요청 보기',
                    style: Theme.of(context).textTheme.bottomTextStyle),
                const Icon(Icons.arrow_right_sharp)
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
          margin: const EdgeInsets.only(left: 20, top: 10),
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
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.only(bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              drugTypes[index],
                              style: const TextStyle(fontSize: 17),
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
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.only(bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              regions[index],
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Icon(Icons.arrow_drop_down_outlined)
                          ],
                        ));
                  }),
            ])),
      ],
    );
  }
}
