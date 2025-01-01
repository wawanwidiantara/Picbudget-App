import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/picplan/views/create_picplan_view.dart';
import 'package:picbudget_app/app/modules/picplan/views/picplan_detail_view.dart';
import '../controllers/picplan_controller.dart';

class PicplanView extends GetView<PicplanController> {
  const PicplanView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PicplanController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budgets',
                        style: AppTypography.headlineSmall.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'How much i can spend this month?',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 24),
                      Obx(
                        () => controller.plans.isEmpty
                            ? Center(
                                child: Text(
                                  'No plans yet',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                            : ListPlan(controller: controller),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListPlan extends StatelessWidget {
  const ListPlan({
    super.key,
    required this.controller,
  });

  final PicplanController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.plans.length,
      itemBuilder: (context, index) {
        final plan = controller.plans[index];
        return Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: ScrollMotion(),
            children: [
              Builder(
                builder: (cont) {
                  return Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => Dialog(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Title
                                  Text(
                                    'Are you sure?',
                                    textAlign: TextAlign.center,
                                    style:
                                        AppTypography.headlineMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Description
                                  Text(
                                    "Deleting this plan will remove it and all its plan history permanently. If you're sure, you can proceed—but remember, this action can't be undone!",
                                    textAlign: TextAlign.center,
                                    style: AppTypography.bodyLarge.copyWith(
                                      height: 1.5,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Button(
                                          type: ButtonType.tertiary,
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          label: 'Not now',
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Button(
                                          type: ButtonType.danger,
                                          onPressed: () {
                                            if (plan.id != null) {
                                              controller.deletePlan(plan.id!);
                                            }
                                            Navigator.of(dialogContext).pop();
                                          },
                                          label: 'Delete',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: AppColors.error.errorColor500,
                        padding: EdgeInsets.all(10),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: AppColors.white,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Get.to(() => PicplanDetailView(), arguments: plan.id);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.neutral.neutralColor600,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.name ?? '',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            plan.remaining.toString(),
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: plan.progress! / 100,
                    backgroundColor: AppColors.neutral.neutralColor300,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'PicPlan',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.track_changes_rounded,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => CreatePicplanView());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
