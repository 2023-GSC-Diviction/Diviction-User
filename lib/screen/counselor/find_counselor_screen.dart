import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/widget/counselor_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/counselor.dart';
import '../../model/drug.dart';
import '../../provider/counselor_provider.dart';
import '../../service/drug_service.dart';

final counselorListProvider =
    StateNotifierProvider.autoDispose<CounselorProvider, List<Counselor>>(
        (ref) => CounselorProvider());

final drugListProvider = FutureProvider.autoDispose<List<Drug>>((ref) async {
  return await DrugService().getDrugs();
});

class FindCounselorScreen extends ConsumerStatefulWidget {
  const FindCounselorScreen({super.key});

  @override
  _CounselorScreenState createState() => _CounselorScreenState();
}

class _CounselorScreenState extends ConsumerState<FindCounselorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    ref.read(counselorListProvider.notifier).getCounselor();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counselorList = ref.watch(counselorListProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Counselor', style: TextStyles.titleTextStyle),
                    SizedBox(
                      width: 4,
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text('contact us!',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w300)))
                  ])),
          // searchBar(),

          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            optionButton(0),
            const SizedBox(
              width: 10,
            ),
            optionButton(1)
          ]),
          Expanded(
              child: counselorList.isEmpty
                  ? const Center(child: Text('Loading...'))
                  : CounselorList(
                      counselor: counselorList,
                    ))
        ],
      ),
    );
  }

  Widget searchBar() {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: Palette.borderColor),
        borderRadius: BorderRadius.circular(10));
    return TextField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          hintText: '#Tag search',
          enabledBorder: border,
          border: border,
          prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 13), child: Icon(Icons.search))),
    );
  }

  Widget optionButton(int type) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18))),
        onPressed: () {
          optionSheet(type);
        },
        child: Row(
          children: [
            Text(type == 0 ? 'type' : 'region',
                style: TextStyles.optionButtonTextStyle),
            const Icon(Icons.arrow_drop_down, color: Colors.black87)
          ],
        ));
  }

  void optionSheet(int option) {
    _tabController.index = option;
    Future<void> a = showModalBottomSheet<void>(
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

class OptionBottomSheet extends ConsumerWidget {
  const OptionBottomSheet(
      {required this.tabIndex, required this.tabController, super.key});

  final int tabIndex;
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var drugList = ref.watch(drugListProvider);
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
              ...drugList.when(
                  data: (data) => [
                        optionList(
                            'type', data.map((e) => e.drugName).toList(), ref)
                      ],
                  error: (e, st) => [
                        Center(
                          child: Text(e.toString()),
                        )
                      ],
                  loading: () =>
                      [const Center(child: CircularProgressIndicator())]),
              optionList('region', regions, ref),
            ])),
      ],
    );
  }

  Widget optionList(String type, List<String> list, WidgetRef ref) =>
      ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  ref
                      .read(counselorListProvider.notifier)
                      .addOption('type', list[index]);

                  Navigator.pop(context);
                },
                child: Container(
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
                    padding: index != 0
                        ? const EdgeInsets.symmetric(vertical: 13)
                        : const EdgeInsets.only(bottom: 13),
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
                    )));
          });
}
