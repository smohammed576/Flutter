import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/colors.dart';

class DetailsBarChart extends StatelessWidget {
  final List<String> xAxisList;
  final List<double> yAxisList;
  final String theme;

  const DetailsBarChart({
    super.key,
    required this.xAxisList,
    required this.yAxisList,
    required this.theme,
  });
  @override
  Widget build(BuildContext context) {
    double maxValue = yAxisList.reduce(math.max);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: maxValue,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                      interval: 1,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index < 0 || index >= xAxisList.length) {
                          return SizedBox.shrink();
                        }
                        return Text(
                          xAxisList[index],
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        );
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  border: Border(
                    top: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                    bottom: BorderSide.none,
                  ),
                ),
                barGroups: List.generate(yAxisList.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: yAxisList[index],
                        width: 15,
                        color: AppColors.appColors[theme],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
          child: Row(
            // spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(xAxisList.length, (index) {
              if (index >= xAxisList.length) {
                return Text(
                  '${int.parse(xAxisList[index - 1]) + 1}',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                );
              } else {
                return Text(
                  '${xAxisList[index]}',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
