import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:diviction_user/config/style.dart';
import 'package:diviction_user/model/network_result.dart';
import 'package:diviction_user/provider/survey_provider.dart';
import 'package:diviction_user/widget/googleMap/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final surveyProvider =
    StateNotifierProvider.autoDispose<SurveyState, SaveState>(
        (ref) => SurveyState());

class SurveyResult extends ConsumerWidget {
  SurveyResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _progress = 0;
    int _maxprogress = 0;

    String grade = '';
    String content = '';
    String result = '';

    // data[0] == data, data[1]은 type으로 'DASS', 'DAST', 'AUDIT'등이 옴
    final data = ModalRoute.of(context)?.settings.arguments as List;
    switch (data[1]) {
      case 'DAST':
        ref.read(surveyProvider.notifier).DASTdataSave(data[0]);
        _progress = data[0].toJson()['question'];
        var response = getDASTExplane(_progress);
        grade = response[0];
        content = response[1];
        result = response[2];
        _maxprogress = 10;
        break;
      case 'DASS':
        ref.read(surveyProvider.notifier).DASSdataSave(data[0]);
        _progress = data[0].toJson()['melancholyScore'];
        _maxprogress = 42;
        break;
      case 'AUDIT':
        ref.read(surveyProvider.notifier).AUDITdataSave(data[0]);
        _progress = data[0].toJson()['score'];
        var response = getAUDITExplane(_progress);
        grade = response[0];
        content = response[1];
        result = response[2];
        _maxprogress = 40;
        break;
    }

    // ref.read(SurveyProvider.notifier).DSATdataSave(surveyDAST);
    // latitude - 위도, longitude - 경도
    final LatLng HomeLatLng = LatLng(
      37.3457,
      126.7419,
    );
    final CameraPosition initialPosition = CameraPosition(
      target: HomeLatLng,
      zoom: 12,
    );
    double RoundDistance = 100;

    List<Color> Linear_colors = const [
      Colors.blue,
      Color(0xFF50C878),
      Color(0xFFFDB813),
      Color(0xFFFF8C00),
      Color(0xFFEE2C2C),
      Color(0xFFB22222),
    ];

    return Scaffold(
      appBar: const MyAppbar(
        isMain: false,
        title: 'Survey Result',
        hasBack: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: data[1] != 'DASS'
                          ? Stack(
                              children: [
                                IgnorePointer(
                                  ignoring: true,
                                  child: CircularSeekBar(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    progress: _progress.toDouble(),
                                    maxProgress: _maxprogress.toDouble(),
                                    barWidth: 8,
                                    startAngle: 45,
                                    sweepAngle: 270,
                                    dashWidth: 5,
                                    dashGap: 1.5,
                                    strokeCap: StrokeCap.butt,
                                    trackColor: Colors.black12,
                                    progressGradientColors: Linear_colors,
                                    innerThumbRadius: 5,
                                    innerThumbStrokeWidth: 3,
                                    innerThumbColor: Colors.white,
                                    outerThumbRadius: 5,
                                    outerThumbStrokeWidth: 10,
                                    outerThumbColor: getColorForValue(
                                        _progress, _maxprogress, Linear_colors),
                                    animation: true,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$_progress / $_maxprogress',
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Image.asset(
                                  width: 360,
                                  height: 50,
                                  'assets/images/Legend.png',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _Bar(
                                    currentValue: data[0]
                                        .toJson()['melancholyScore']
                                        .toDouble(),
                                    color: Color(0xFF177AD1),
                                    typeText: 'Depress'),
                                SizedBox(height: 10),
                                _Bar(
                                    currentValue: data[0]
                                        .toJson()['unrestScore']
                                        .toDouble(),
                                    color: Color(0xFFFF975B),
                                    typeText: 'Anxious'),
                                SizedBox(height: 10),
                                _Bar(
                                    currentValue: data[0]
                                        .toJson()['stressScore']
                                        .toDouble(),
                                    color: Color(0xFFEA6763),
                                    typeText: 'Stress'),
                              ],
                            ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      grade,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      result,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    /* test를 위해 주석처리함
                    Text(
                      "[내 위치 근처의 치료센터]",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    _SizedBox(context, 0.01),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: GoogleMap(
                        initialCameraPosition: initialPosition,
                        markers: _markers,
                      ),
                    ),
                    */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _SizedBox(BuildContext context, double value) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * value,
    );
  }

  List<String> getDASTExplane(int score) {
    if (score == 0) {
      return ['I. No risk', 'No risk of related health problems', 'None'];
    } else if (score < 2) {
      return [
        'II – Risky',
        'Risk of health problems related to drug use.',
        'Offer brief education on the benefits of abstaining from drug use. Monitor at future visits.'
      ];
    } else if (score < 5) {
      return [
        'III – Harmful',
        'Risk of health problems related to drug use and a possible mild or moderate substance use disorder',
        'Brief intervention (offer options that include treatment)'
      ];
    } else {
      return [
        'IV – Severe',
        'Risk of health problems related to drug use and a possible mild or moderate substance use disorder',
        'Brief intervention (offer options that include treatment)'
      ];
    }
  }

  List<String> getAUDITExplane(int score) {
    if (score < 5) {
      return [
        'I. Low risk',
        'Low risk of health problems related to alcohol use',
        'Brief education'
      ];
    } else if (score < 15) {
      return [
        'II – Risky',
        'Increased risk of health problems related to alcohol use.',
        'Brief intervention'
      ];
    } else if (score < 20) {
      return [
        'III – Harmful',
        'Increased risk of health problems related to alcohol use and a possible mild or moderate alcohol use disorder.',
        'Brief intervention (offer options that include medications and referral to treatment)'
      ];
    } else {
      return [
        'IV – Severe',
        'Increased risk of health problems related to alcohol use and a possible moderate or severe alcohol use disorder.',
        'Brief intervention (offer options that include medications and referral to treatment)'
      ];
    }
  }
  List<String> getDASSExplane(int score) {
    if (score < 5) {
      return [
        'I. Low risk',
        'Low risk of health problems related to alcohol use',
        'Brief education'
      ];
    } else if (score < 15) {
      return [
        'II – Risky',
        'Increased risk of health problems related to alcohol use.',
        'Brief intervention'
      ];
    } else if (score < 20) {
      return [
        'III – Harmful',
        'Increased risk of health problems related to alcohol use and a possible mild or moderate alcohol use disorder.',
        'Brief intervention (offer options that include medications and referral to treatment)'
      ];
    } else {
      return [
        'IV – Severe',
        'Increased risk of health problems related to alcohol use and a possible moderate or severe alcohol use disorder.',
        'Brief intervention (offer options that include medications and referral to treatment)'
      ];
    }
  }

  Color getColorForValue(int value, int maxValue, List<Color> colors) {
    // 각 구간 별로 값을 분리
    final numSegments = colors.length - 1;
    final segmentValue = maxValue / numSegments;

    // 현재 value가 어떤 구간에 속하는지 계산
    final segmentIndex =
        (value / segmentValue).floor().clamp(0, numSegments - 1);

    // 해당 구간의 시작 색상, 끝 색상, 그리고 구간 내에서의 비율 계산
    final startColor = colors[segmentIndex];
    final endColor = colors[segmentIndex + 1];
    final segmentProgress =
        (value - (segmentIndex * segmentValue)) / segmentValue;

    // 시작 색상과 끝 색상, 비율을 이용하여 현재 value에 해당하는 색상 계산
    return Color.lerp(startColor, endColor, segmentProgress)!;
  }

  Set<Marker> _markers = {}; // 마커들의 집합

  // 마커 추가 함수
  // void _addMarker(LatLng position, String name) {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId(name),
  //       position: position,
  //       infoWindow: InfoWindow(title: name),
  //     ));
  //   });
  // }
}

class _Bar extends StatelessWidget {
  final currentValue;
  final typeText;
  final color;
  const _Bar({
    Key? key,
    required this.currentValue,
    required this.color,
    required this.typeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FAProgressBar(
          currentValue: currentValue,
          maxValue: 42.0,
          displayText: '',
          size: 35, // 높이
          progressColor: color,
          border: Border.all(width: 1.5, color: Colors.black12),
        ),
        Positioned(
            left: 10,
            top: 9,
            child: Text(
              typeText,
              style: TextStyle(color: Colors.white),
            )),
        Positioned(right: 10, top: 9, child: Text('42')),
      ],
    );
  }
}

/*

// 마커 추가, 0316 : Stateful -> ConsumerWidget 변경하면서 주석처리함
    _addMarker(
      LatLng(37.317070, 126.794583),
      "국민기초생활보장 센터 평택지사",
    );
    _addMarker(
      LatLng(37.312377, 126.763769),
      "평택시 신북보건소 약물의존 치료센터",
    );
    _addMarker(
      LatLng(37.316212, 126.783465),
      "한국사회복지회 평택지회 도약센터",
    );
    _addMarker(
      LatLng(37.304582, 126.750912),
      "평택순복음교회 새소망센터",
    );

 */
