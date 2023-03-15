import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:diviction_user/provider/survey_provider.dart';
import 'package:diviction_user/widget/googleMap/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:diviction_user/widget/appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final surveyProvider = StateNotifierProvider.autoDispose<SurveyState, TestState>(
        (ref) => SurveyState());

class SurveyResult extends ConsumerWidget {
  SurveyResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ModalRoute.of(context)?.settings.arguments as dynamic;
    ref.read(surveyProvider.notifier).DSATdataSave(data);
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

    int _progress = 30;
    int _maxprogress = 40;

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
                      child: Stack(
                        children: [
                          CircularSeekBar(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
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
                          Center(
                            child: Text(
                              '$_progress점',
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      "3단계. 유해",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      "알코올 사용과 관련된 건강 문제의 위험이 증가하고 경미하거나 중간 정도의 알코올 사용 장애가 발생할 수 있습니다.",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    _SizedBox(context, 0.03),
                    Text(
                      "검사 결과 : 약물 및 치료 의뢰가 필요합니다.",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    _SizedBox(context, 0.03),
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