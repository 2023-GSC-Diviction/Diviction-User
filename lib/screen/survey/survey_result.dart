import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:diviction_user/widget/appbar.dart';

class SurveyResult extends StatefulWidget {
  const SurveyResult({Key? key}) : super(key: key);

  @override
  State<SurveyResult> createState() => _SurveyResultState();
}

class _SurveyResultState extends State<SurveyResult> {
  @override
  Widget build(BuildContext context) {
    int _progress = 30;
    Map<String, Color> ColorMap = {
      '안전': Color(0xFF50C878),
      '경고': Color(0xFFFDB813),
      '주의': Color(0xFFFF8C00),
      '위험': Color(0xFFEE2C2C),
      '심각': Color(0x00B22222),
    };

    return Scaffold(
      appBar: const MyAppbar(
        isMain: false,
        title: 'Survey Result',
        hasBack: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    CircularSeekBar(
                      width: double.infinity,
                      height: 250,
                      progress: _progress.toDouble(),
                      maxProgress: 40,
                      barWidth: 10,
                      startAngle: 45,
                      sweepAngle: 270,
                      dashWidth: 5,
                      dashGap: 1.5,
                      strokeCap: StrokeCap.butt,
                      progressGradientColors: const [
                        Colors.blue,
                        Color(0xFF50C878),
                        Color(0xFFFDB813),
                        Color(0xFFFF8C00),
                        Color(0xFFEE2C2C),
                        Color(0xFFB22222),
                      ],
                      innerThumbRadius: 5,
                      innerThumbStrokeWidth: 3,
                      innerThumbColor: Colors.white,
                      outerThumbRadius: 5,
                      outerThumbStrokeWidth: 10,
                      outerThumbColor: Colors.orange,
                      animation: true,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.43 - 30,
                      child: Text(
                        '$_progress점',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ]),
                  _SizedBox(0.03),
                  Text(
                    "3단계. 유해",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  _SizedBox(0.03),
                  Text(
                    "알코올 사용과 관련된 건강 문제의 위험이 증가하고 경미하거나 중간 정도의 알코올 사용 장애가 발생할 수 있습니다.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  _SizedBox(0.03),
                  Text(
                    "검사 결과 : 약물 및 치료 의뢰가 필요합니다.",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _SizedBox(double value) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * value,
    );
  }
}
