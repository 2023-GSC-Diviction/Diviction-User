import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/screen/counselor/requested_counselor_screen.dart';
import 'package:diviction_user/widget/counselor_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FindCounselorScreen extends StatefulWidget {
  const FindCounselorScreen({super.key});

  @override
  State<FindCounselorScreen> createState() => _CounselorScreenState();
}

class _CounselorScreenState extends State<FindCounselorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

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
    return Stack(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('상담사 찾기', style: TextStyles.titleTextStyle),
            ),
            searchBar(),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              optionButton(0),
              const SizedBox(
                width: 10,
              ),
              optionButton(1)
            ]),
            Expanded(
                child: CounselorList(
              counselorList: counselorList,
              requested: false,
            ))
          ],
        ),
      ),
    ]);
  }

  Widget searchBar() {
    return TextField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1, color: Palette.borderColor)),
          contentPadding: const EdgeInsets.all(0),
          hintText: '#Tag search',
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, color: Color.fromARGB(67, 28, 28, 28)),
              borderRadius: BorderRadius.circular(10)),
          prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 13), child: Icon(Icons.search))),
    );
  }

  Widget optionButton(int type) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 1, color: Palette.borderColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        onPressed: () {
          optionSheet(type);
        },
        child: Row(
          children: [
            Text(type == 1 ? 'type' : 'region',
                style: TextStyle(color: Colors.black87)),
            const Icon(Icons.arrow_drop_down, color: Colors.black87)
          ],
        ));
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
        builder: (BuildContext context) => OptionBottomSheet(
              tabIndex: option,
              tabController: _tabController,
            ));
  }
}

class OptionBottomSheet extends StatelessWidget {
  const OptionBottomSheet(
      {required this.tabIndex, required this.tabController, super.key});

  final int tabIndex;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
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
          margin: const EdgeInsets.only(left: 10, top: 10),
          width: 160,
          child: TabBar(
              tabs: const [
                Tab(
                  text: 'type',
                ),
                Tab(
                  text: 'region',
                )
              ],
              onTap: (value) => tabController.animateTo(value),
              controller: tabController,
              labelColor: Colors.blue[300],
              unselectedLabelColor: Colors.black54,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: TabBarView(controller: tabController, children: [
              optionList(drugTypes),
              optionList(regions),
            ])),
      ],
    );
  }

  Widget optionList(List list) => ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                  list[index],
                  style: const TextStyle(fontSize: 17),
                ),
                const Icon(Icons.arrow_drop_down_outlined)
              ],
            ));
      });
}