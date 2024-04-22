import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChartSample extends StatelessWidget {
  final List<_ChartData> data;
  final Color colord;

  const SplineChartSample(
      {super.key, required this.data, required this.colord});
  @override
  Widget build(BuildContext context) {
    return _buildSplineChart(data, colord);
  }

  Widget _buildSplineChart(List<_ChartData> value, Color colord) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.all(0),
      borderColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      borderWidth: 0,
      primaryXAxis: const CategoryAxis(
        isVisible: false,
        interval: 1,
        borderWidth: 0,
        borderColor: Colors.transparent,
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        labelStyle: TextStyle(
          color: Colors.transparent, /* fontSize: 0 */
        ),
        axisLine: AxisLine(width: 0, color: Colors.transparent),
      ),
      primaryYAxis: const NumericAxis(
        interval: 1000,
        borderWidth: 0,
        borderColor: Colors.transparent,
        plotOffset: 0,
        isVisible: false,
        majorGridLines: MajorGridLines(width: 0),
        minorGridLines: MinorGridLines(width: 0),
        labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
        majorTickLines: MajorTickLines(width: 0),
        axisLine: AxisLine(width: 0, color: Colors.transparent),
      ),
      series: [
        SplineAreaSeries<_ChartData, String>(
          // initialIsVisible: false,
          dataSource: value,
          xValueMapper: (_ChartData sales, _) => sales.month,
          yValueMapper: (_ChartData sales, _) => sales.sales,
          gradient: LinearGradient(colors: [
            colord,
            colord.withOpacity(0.7),
            colord.withOpacity(0.5),
            colord.withOpacity(0.2)
          ]),
        ),
      ],
    );
  }
}

class _ChartData {
  final String month;
  final double sales;

  _ChartData(this.month, this.sales);
}

List<_ChartData> profitdata = [
  _ChartData('1', 30),
  _ChartData('2', 550),
  _ChartData('3', 40),
  _ChartData('4', 660),
  _ChartData('5', 710),
];

List<_ChartData> lossdata = [
  _ChartData('5', 170),
  _ChartData('4', 0),
  _ChartData('3', 150),
  _ChartData('2', 172),
  _ChartData('1', 0),
];
