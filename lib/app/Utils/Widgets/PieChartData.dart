//PieChartData
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class PieChartData extends StatelessWidget {
  const PieChartData({
    super.key,
    required this.data,
    required this.fillColor,
    required this.pieLabel,
    this.donutWidth = 100,
  });

  final List<Map<String, dynamic>> data;
  final Function(Map<String, dynamic> pieData, int? index) fillColor;
  final Function(Map pieData, int? index)? pieLabel;
  final int donutWidth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: DChartPie(
        data: data,
        fillColor: fillColor,
        labelColor: Colors.white,
        labelFontSize: 12,
        showLabelLine: true,
        strokeWidth: 2,
        labelLineColor: Colors.yellow,
        labelPosition: PieLabelPosition.outside,
        pieLabel: pieLabel,
        donutWidth: donutWidth,
      ),
    );
  }
}
