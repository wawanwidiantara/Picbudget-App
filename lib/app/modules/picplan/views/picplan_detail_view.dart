import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picbudget_app/app/modules/picplan/controllers/picplan_controller.dart';

class PicplanDetailView extends GetView<PicplanController> {
  const PicplanDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PicplanController());
    final arguments = Get.arguments;
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.name ?? "Plan Details",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
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
              Text(
                  "Progress: ${(plan.progress ?? 0.0) * 100}% | Overspent: ${plan.isOverspent == true ? 'Yes' : 'No'}"),
            ],
          ),
        );
      }),
    );
  }
}
