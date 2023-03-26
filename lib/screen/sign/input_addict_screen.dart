import 'package:diviction_user/model/drug.dart';
import 'package:diviction_user/service/drug_service.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/style.dart';
import '../bottom_nav.dart';

final drugProvider = FutureProvider((ref) => DrugService().getDrugs());
final selectedType = StateProvider((ref) => InputAddictType.alcohol);

enum InputAddictType { alcohol, drug }

class InputAddictScreen extends ConsumerStatefulWidget {
  const InputAddictScreen({super.key});

  @override
  _InputAddictScreenState createState() => _InputAddictScreenState();
}

class _InputAddictScreenState extends ConsumerState<InputAddictScreen> {
  final addictlist = ['Alcohol', 'Drug'];
  final druglist = [
    'Cannabis',
    'Cocaine',
    'Heroin',
    'Methamphetamine',
    'Ecstasy',
    'Ketamine',
    'LSD',
    'Mushrooms',
    'Opioids',
    'PCP',
    'Steroids',
    'Vicodin',
    'Xanax',
    'Other'
  ];
  Drug selectedDrug = Drug(drugName: 'Cannabis', id: 1);
  @override
  Widget build(BuildContext context) {
    final drugs = ref.watch(drugProvider);
    final types = ref.watch(selectedType);

    return Scaffold(
        appBar: const MyAppbar(isMain: false, hasBack: false),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  const Text('Choose your addiction type!',
                      style: TextStyles.titleTextStyle),
                  const SizedBox(height: 20),
                  RadioListTile(
                      title: const Text(
                        'alcohol',
                        style: TextStyles.answerTextStyle,
                      ),
                      activeColor: Palette.appColor2,
                      value: InputAddictType.alcohol,
                      groupValue: types,
                      onChanged: (value) => ref
                          .read(selectedType.notifier)
                          .state = value as InputAddictType),
                  RadioListTile(
                      title: const Text(
                        'drug',
                        style: TextStyles.answerTextStyle,
                      ),
                      activeColor: Palette.appColor2,
                      value: InputAddictType.drug,
                      groupValue: types,
                      onChanged: (value) => ref
                          .read(selectedType.notifier)
                          .state = value as InputAddictType),
                  if (types == InputAddictType.drug) ...[
                    drugs.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return drugListWidget(druglist
                                .map((e) => Drug(drugName: e, id: 1))
                                .toList());
                          } else {
                            return drugListWidget(data);
                          }
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                    decoration: const InputDecoration(
                                        labelText: 'input your drug'),
                                    onChanged: (value) => selectedDrug =
                                        Drug(id: 1, drugName: value))
                              ],
                            )))
                  ]
                ]),
                saveButton(context)
              ],
            )));
  }

  Widget drugListWidget(List<Drug> drugs) {
    return Container(
        padding: const EdgeInsets.only(left: 25),
        height: 350,
        child: StatefulBuilder(builder: ((context, setState) {
          return ListView.builder(
              itemCount: drugs.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                    title: Text(
                      drugs[index].drugName,
                      style: TextStyles.answerTextStyle,
                    ),
                    activeColor: Palette.appColor,
                    value: drugs[index],
                    groupValue: selectedDrug,
                    onChanged: (value) => setState(() {
                          selectedDrug = value as Drug;
                        }));
              });
        })));
  }

  Widget drugListWidgetCheckBox(List<Drug> drugs) {
    return Container(
        padding: const EdgeInsets.only(left: 25),
        height: 350,
        child: StatefulBuilder(builder: ((context, setState) {
          return ListView.builder(
              itemCount: drugs.length,
              itemBuilder: (context, index) {
                return Row(children: [
                  Checkbox(
                      value: drugs.contains(drugs[index]),
                      onChanged: (value) {
                        if (value!) {}
                      }),
                  Text(drugs[index].drugName)
                ]);
              });
        })));
  }

  Widget saveButton(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: Palette.appColor2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Save',
          style: TextStyles.dialogConfirmTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        DrugService().saveDrug(selectedDrug);
        Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    const BottomNavigation()) // 리버팟 적용된 HomeScreen 만들기
            );
      },
    );
  }
}
