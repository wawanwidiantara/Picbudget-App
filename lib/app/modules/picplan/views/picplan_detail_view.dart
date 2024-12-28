import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/modules/picplan/controllers/picplan_controller.dart';

class PicplanDetailView extends GetView<PicplanController> {
  const PicplanDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PicplanController());
    final arguments = Get.arguments;
    final now = DateTime.now();
    final totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final maxX = totalDaysInMonth.toDouble();
    final firstDay = 1;
    final mid1 = (totalDaysInMonth - 10).ceil();
    final mid2 = (totalDaysInMonth - 10 * 2).ceil();
    final lastDay = totalDaysInMonth;
    final today = now.day;
    controller.fetchPlanDetail(arguments);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Details'),
        centerTitle: true,
      ),
      body: Obx(() {
        final plan = controller.selectedPlan.value;
        if (plan.id == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name ?? "Plan Details",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Daily Avg: IDR ${plan.dailyAverage?.toStringAsFixed(2) ?? '0.00'}"),
                  Text(
                      "Daily Rec: IDR ${plan.dailyRecommended?.toStringAsFixed(2) ?? '0.00'}"),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                  "Progress: ${(plan.progress ?? 0.0)}% | Overspent: ${plan.isOverspent == true ? 'Yes' : 'No'}"),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                width: Get.width - 72,
                child: LineChart(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  LineChartData(
                    minX: 1,
                    maxX: maxX.toDouble(),
                    minY: 0,
                    maxY: plan.amount ?? 0,
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
                          reservedSize: 54,
                          interval: plan.amount != null && plan.amount! > 0
                              ? (plan.amount! / 4).ceilToDouble()
                              : 200000,
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
                          y: plan.amount ?? 0,
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
                        spots: plan.picPlanChart?.beforeLimit
                                ?.map((e) =>
                                    FlSpot(e[0].toDouble(), e[1].toDouble()))
                                .toList() ??
                            [],
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
                        spots: plan.picPlanChart?.afterLimit
                                ?.map((e) =>
                                    FlSpot(e[0].toDouble(), e[1].toDouble()))
                                .toList() ??
                            [],
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
