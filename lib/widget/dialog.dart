import 'package:diviction_user/config/style.dart';
import 'package:flutter/material.dart';

Future<bool> backDialog(BuildContext context) async {
  String text = '취소하고 뒤로 가시겠습니까?\n';

  return await showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => AlertDialog(
            buttonPadding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text.rich(
                  TextSpan(
                      text: text,
                      style: TextStyles.dialogTextStyle,
                      children: const <TextSpan>[
                        TextSpan(
                          text: '(기록이 삭제됩니다)',
                          style: TextStyles.dialogTextStyle2,
                        )
                      ]),
                  textAlign: TextAlign.center,
                )),
            actions: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: Row(
                    children: [
                      Flexible(
                          child: InkWell(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(234, 234, 234, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '취소',
                            style: TextStyles.dialogCancelTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                      )),
                      Flexible(
                          child: InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '확인',
                            style: TextStyles.dialogConfirmTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        },
                      ))
                    ],
                  ))
            ],
          ));
}
