import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpRangeChartSample extends StatelessWidget {
  final List<ChartData> data;
  final Color colord;

  const SpRangeChartSample(
      {super.key, required this.data, required this.colord});
  @override
  Widget build(BuildContext context) {
    return _buildSplineChart(data, colord);
  }

  Widget _buildSplineChart(List<ChartData> value, Color colord) {
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
        labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
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
        SplineAreaSeries<ChartData, String>(
          // initialIsVisible: false,
          dataSource: value,
          xValueMapper: (ChartData sales, _) => sales.month,
          yValueMapper: (ChartData sales, _) => sales.sales,
          gradient: LinearGradient(colors: [
            colord,
            colord.withOpacity(0.7),
            colord.withOpacity(0.5),
            colord.withOpacity(0.1)
          ]),
        ),
      ],
    );
  }
}

class ChartData {
  final String month;
  final double sales;

  ChartData(this.month, this.sales);
}

List<ChartData> profitdata = [
  ChartData('1', 130),
  ChartData('2', 1550),
  ChartData('3', 440),
  ChartData('4', 660),
  ChartData('5', 3710),
];

List<ChartData> lossdata = [
  ChartData('5', 550),
  ChartData('4', 60),
  ChartData('3', 750),
  ChartData('2', 972),
  ChartData('1', 10),
];
List<ChartData> fprofitdata = [
  ChartData('1', 130),
  ChartData('2', 1550),
  ChartData('3', 440),
  ChartData('4', 660),
  ChartData('5', 3710),
  ChartData('6', 130),
  ChartData('7', 1550),
  ChartData('8', 440),
  ChartData('9', 660),
  ChartData('10', 3710),
   ChartData('11', 130),
  ChartData('12', 1550),
  ChartData('13', 440),
  ChartData('14', 660),
  ChartData('15', 3710),
];

List<ChartData> flossdata = [
  ChartData('5', 550),
  ChartData('4', 60),
  ChartData('3', 750),
  ChartData('2', 972),
  ChartData('1', 10),
   ChartData('6', 130),
  ChartData('7', 1550),
  ChartData('8', 440),
  ChartData('9', 660),
  ChartData('10', 3710),
   ChartData('15', 550),
  ChartData('14', 60),
  ChartData('13', 750),
  ChartData('12', 972),
  ChartData('11', 10),
];

class SplineChartSample extends StatelessWidget {
  final List<ChartData> data;
  final Color colord;

  const SplineChartSample(
      {super.key, required this.data, required this.colord});
  @override
  Widget build(BuildContext context) {
    return _buildSplineChart(data, colord);
  }

  Widget _buildSplineChart(List<ChartData> value, Color colord) {
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
        labelStyle: TextStyle(color: Colors.transparent, fontSize: 0),
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
        FastLineSeries<ChartData, String>(
          dataSource: value,
          xValueMapper: (ChartData sales, _) => sales.month,
          yValueMapper: (ChartData sales, _) => sales.sales,
          color: colord,
          width: 1,
          opacity: 0.8,
        ),
      ],
    );
  }
}
// SfCartesianChart(
//   series: [
//     FastLineSeries<YourDataClass, int>( // Replace with your data class type
//       dataSource: yourDataList, // Replace with your data list
//       xAxisMapper: (data, _) => data.xValue, // X-axis value mapper
//       yAxisMapper: (data, _) => data.yValue, // Y-axis value mapper
//       color: Colors.blue, // Set your desired line color
//       opacity: 0.8, // Adjust line opacity (0.0 to 1.0)
//     ),
//   ],
// );