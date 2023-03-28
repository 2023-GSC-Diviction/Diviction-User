import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../config/style.dart';
import '../../model/survey_result.dart';
import '../../util/date_formatter.dart';

class SurveyChart extends StatefulWidget {
  final List<Map<String, dynamic>> list;
  final double maxY;
  final bool multiLine; // DASS인경우 3개의 그래프가 그려져야함 -> true 이외엔 false
  // DASS를 위한 데이터 리스트
  List<Map<String, dynamic>>? list1 = null;
  List<Map<String, dynamic>>? list2 = null;
  List<Map<String, dynamic>>? list3 = null;

  SurveyChart({
    Key? key,
    required this.list,
    required this.maxY,
    required this.multiLine,
  });

  @override
  State<SurveyChart> createState() => _SurveyChartState();
}

class _SurveyChartState extends State<SurveyChart> {
  List<Color> gradientColors = [Colors.blue[300]!, Colors.blue[800]!];
  List<Color> gradientColors1 = [Color(0xFF177AD1), Color(0xD7177AD1)]; // D 우울
  List<Color> gradientColors2 = [Color(0xFFFF975B), Color(0xD7FF975B)]; // A 불안
  List<Color> gradientColors3 = [
    Color(0xFFEA6763),
    Color(0xD7EA6763)
  ]; // S 스트레스
  double max = 30;
  int numberPrintOnGraph = 7; // 7개
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    touchedIndex = -1;

    if (widget.list.length >= 2) {
      widget.list.sort((a, b) => DateTimeFormatter.parse(a['date'])
          .compareTo(DateTimeFormatter.parse(b['date'])));
    }

    if (widget.list != null && widget.multiLine) {
      // DASS 데이터를 우울, 불안, 스트레스에 따라 3개의 데이터 리스트로 분류하기
      widget.list1 = widget.list
          .map((item) =>
              {"score": item["melancholyScore"], "date": item["date"]})
          .toList();
      widget.list2 = widget.list
          .map((item) => {"score": item["unrestScore"], "date": item["date"]})
          .toList();
      widget.list3 = widget.list
          .map((item) => {"score": item["stressScore"], "date": item["date"]})
          .toList();
      // print(widget.list1);
      // print(widget.list2);
      // print(widget.list3);
      // 데이터 정렬
    } else {
      max = widget.list
          .reduce((value, element) =>
              value['score'] > element['score'] ? value : element)['score']
          .toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 6,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchCallback:
            (FlTouchEvent touchEvent, LineTouchResponse? touchResponse) {
          if (touchResponse == null || touchResponse.lineBarSpots!.isEmpty) {
            setState(() {
              touchedIndex = -1;
            });
          } else {
            final firstSpot = touchResponse.lineBarSpots!.first;
            setState(() {
              touchedIndex = firstSpot.spotIndex;
            });
          }
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.blue, strokeWidth: 4),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 8,
                    color: Colors.white,
                    strokeWidth: 5,
                    strokeColor: Colors.blue,
                  );
                },
              ),
            );
          }).toList();
        },
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black54.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.black54.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black54.withOpacity(0.3), width: 1.0),
      ),
      minX: 0,
      maxX: numberPrintOnGraph > (widget.list.length.toDouble() - 1)
          ? widget.list.length.toDouble() - 1
          : numberPrintOnGraph - 1,
      minY: 0,
      maxY: widget.maxY,
      lineBarsData: (!widget.multiLine)
          ? [
              // DAST, AUDIT
              GraphLineDatas(DataProcessing(widget.list), gradientColors),
            ]
          : widget.list3 != null
              ? [
                  // DASS
                  GraphLineDatas(
                      DataProcessing(widget.list1!), gradientColors1),
                  GraphLineDatas(
                      DataProcessing(widget.list2!), gradientColors2),
                  GraphLineDatas(DataProcessing(widget.list3!), gradientColors3)
                ]
              : [],
    );
  }

  /** 데이터가 7개 이상이라면 앞(과거)의 데이터를 자르고, 7개 이하라면 앞쪽에 빈 데이터 추가 */
  List<Map<String, dynamic>> DataProcessing(
      List<Map<String, dynamic>> dataList) {
    if (dataList.length > numberPrintOnGraph) {
      int temp = dataList.length - numberPrintOnGraph;
      dataList = dataList.sublist(temp, dataList.length);
    }
    // else {
    //   final diff = numberPrintOnGraph - dataList.length;
    //   for (var i = 0; i < diff; i++) {
    //     dataList.insert(0, {"score": 0, "date": null});
    //   }
    // }
    return dataList;
  }

  LineChartBarData GraphLineDatas(
      List<Map<String, dynamic>> graphData, List<Color> gradientColors) {
    return LineChartBarData(
      spots: graphData.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value['score'].toDouble());
      }).toList(),
      isCurved: true,
      gradient: LinearGradient(
        colors: gradientColors,
      ),
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors:
              gradientColors.map((color) => color.withOpacity(0.1)).toList(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String date =
        DateTimeFormatter.formatCustom(widget.list[value.toInt()]['date']);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        date,
        style: TextStyles.descriptionTextStyle,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final maxValue = max.toInt();
    if (value.toInt() % 10 == 0 || value.toInt() == maxValue) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          value.toInt().toString(),
          style: TextStyles.descriptionTextStyle,
        ),
      );
    } else {
      return Container();
    }
  }
}
