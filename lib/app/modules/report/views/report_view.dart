import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final maxX = totalDaysInMonth.toDouble();
    final firstDay = 1;
    final mid1 = (totalDaysInMonth - 10).ceil();
    final mid2 = (totalDaysInMonth - 10 * 2).ceil();
    final lastDay = totalDaysInMonth;
    final today = now.day;
    final limit = 1200000;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReportView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
            child: SizedBox(
          height: 300,
          child: LineChart(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            LineChartData(
              minX: 1,
              maxX: maxX.toDouble(),
              minY: 0,
              maxY: limit.toDouble(),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() == firstDay) {
                        return Text(
                          '$firstDay/${now.month}',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                          ),
                        );
                      } else if (value.toInt() == mid1) {
                        return Text(
                          '$mid1/${now.month}',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                          ),
                        );
                      } else if (value.toInt() == mid2) {
                        return Text(
                          '$mid2/${now.month}',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                          ),
                        );
                      } else if (value.toInt() == lastDay) {
                        return Text(
                          '$lastDay/${now.month}',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                          ),
                        );
                      }
                      return Container();
                    },
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 64,
                    interval: 200000,
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (double value) {
                  return value % 200000 == 0;
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: AppColors.neutral.neutralColor500,
                    strokeWidth: 1,
                  );
                },
                checkToShowVerticalLine: (double value) {
                  return value % 10 == 0;
                },
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: AppColors.neutral.neutralColor500,
                    strokeWidth: 1,
                  );
                },
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: limit.toDouble(),
                    label: HorizontalLineLabel(
                      alignment: Alignment.bottomLeft,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                      labelResolver: (line) => 'Limit',
                      show: true,
                    ),
                    color: AppColors.secondary,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ],
                verticalLines: [
                  VerticalLine(
                    x: today.toDouble(),
                    label: VerticalLineLabel(
                      alignment: Alignment.topLeft,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                      labelResolver: (line) => 'Today',
                      show: true,
                    ),
                    color: AppColors.secondary,
                    strokeWidth: 1,
                  ),
                ],
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(1, 0),
                    FlSpot(2, 200000),
                    FlSpot(3, 200000),
                    FlSpot(4, 200000),
                    FlSpot(5, 800000),
                    FlSpot(6, 800000),
                    FlSpot(7, 800000),
                    FlSpot(8, 800000),
                    FlSpot(9, 800000),
                    FlSpot(10, 800000),
                    FlSpot(11, 800000),
                  ],
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: AppColors.primary,
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.primary.withOpacity(0.2),
                  ),
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
                LineChartBarData(
                  spots: [
                    FlSpot(11, 800000),
                    FlSpot(12, 800000),
                    FlSpot(13, 900000),
                    FlSpot(14, 1000000),
                    FlSpot(15, 1000000),
                  ],
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: AppColors.error.errorColor500,
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.error.errorColor500.withOpacity(0.2),
                  ),
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
