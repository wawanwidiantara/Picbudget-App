import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/picplan/views/create_picplan_view.dart';
import 'package:picbudget_app/app/modules/picplan/views/picplan_detail_view.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
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
                            : GestureDetector(
                                onTap: () {
                                  Get.to(() => PicplanDetailView(),
                                      arguments: controller.plans[0].id);
                                },
                                child: ListPlan(controller: controller),
                              ),
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
        final progress = 50;

        return Container(
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
                        plan.amount.toString(),
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
