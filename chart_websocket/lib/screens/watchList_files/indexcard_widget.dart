import 'package:flattrade7/screens/watchList_files/linechart.dart';
import 'package:flutter/material.dart';

  Widget buildChartCard(String title, String value, String percentage,
      Color color, List<ChartData> data, AlignmentGeometry algin,BuildContext context,Color textColor) {
    return Material(
      type: MaterialType.card,
      child: SizedBox(
        height: 130,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: algin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      value,
                      style:  TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      percentage,
                      style:  TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: SpRangeChartSample(
                colord: color,
                data: data,
              ),
            ),
          ],
        ),
      ),
    );
  }