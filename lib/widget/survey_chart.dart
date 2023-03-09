import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../config/style.dart';
import '../model/survey_result.dart';
import '../util/date_formatter.dart';

class SurveyChart extends StatefulWidget {
  final List<SurveyData> list;
  const SurveyChart({super.key, required this.list});

  @override
  State<SurveyChart> createState() => _SurveyChartState();
}

class _SurveyChartState extends State<SurveyChart> {
  List<Color> gradientColors = [Colors.blue[300]!, Colors.blue[800]!];
  double max = 30;

  @override
  void initState() {
    super.initState();

    widget.list.sort((a, b) => DateTimeFormatter.parse(a.date)
        .compareTo(DateTimeFormatter.parse(b.date)));

    max = widget.list
        .reduce(
            (value, element) => value.score > element.score ? value : element)
        .score
        .toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
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
            interval: 1,
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
      maxX: widget.list.length.toDouble() - 1,
      minY: 0,
      maxY: max,
      lineBarsData: [
        LineChartBarData(
          spots: widget.list.asMap().entries.map((e) {
            return FlSpot(e.key.toDouble(), e.value.score.toDouble());
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String date =
        DateTimeFormatter.formatCustom(widget.list[value.toInt()].date);
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
