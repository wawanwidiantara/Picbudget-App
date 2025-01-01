import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/core/styles/form_styles.dart';
import 'package:picbudget_app/app/modules/picplan/controllers/create_picplan_controller.dart';

class CreatePicplanView extends GetView {
  const CreatePicplanView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePicplanController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        FormWidget(
                            controller: controller.nameController,
                            label: 'Plan name',
                            hintText: 'Enter plan name',
                            isObsecured: false,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your wallet name';
                              }
                              return null;
                            }),
                        SizedBox(height: 24),
                        FormWidget(
                            controller: controller.amountController,
                            label: 'Amount',
                            hintText: 'Enter wallet amount',
                            isObsecured: false,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your wallet amount';
                              }
                              return null;
                            }),
                        SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Period", style: AppTypography.titleSmall),
                            SizedBox(height: 8),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your plan period';
                                }
                                return null;
                              },
                              dropdownColor: AppColors.white,
                              hint: Text(
                                "Select your plan period",
                                style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.neutral.neutralColor700),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "one-time",
                                  child: Text(
                                    "One-time",
                                    style: AppTypography.bodyMedium
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "weekly",
                                  child: Text(
                                    "Weekly",
                                    style: AppTypography.bodyMedium
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "monthly",
                                  child: Text(
                                    "Monthly",
                                    style: AppTypography.bodyMedium
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "yearly",
                                  child: Text(
                                    "Yearly",
                                    style: AppTypography.bodyMedium
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                controller.periodController.text =
                                    value.toString();
                              },
                              decoration: dropDownFormStyle(),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Labels: ',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 4.0,
                                runSpacing: 0.0,
                                children:
                                    controller.availableLabels.map((label) {
                                  final isSelected =
                                      controller.selectedLabels.contains(label);

                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    child: ChoiceChip(
                                      label: Text(
                                        "${label.emoticon} ${label.name}",
                                        style:
                                            AppTypography.labelMedium.copyWith(
                                          color: isSelected
                                              ? AppColors.secondary
                                              : AppColors.secondary,
                                        ),
                                      ),
                                      backgroundColor: AppColors.white,
                                      selectedColor:
                                          AppColors.brandColor.brandColor25,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors
                                                  .neutral.neutralColor600,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        controller.toggleLabelSelection(label);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 24),
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wallets: ',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 4.0,
                                runSpacing: 0.0,
                                children:
                                    controller.availableWallets.map((wallet) {
                                  final isSelected = controller.selectedWallets
                                      .contains(wallet);

                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    child: ChoiceChip(
                                      label: Text(
                                        wallet.name,
                                        style:
                                            AppTypography.labelMedium.copyWith(
                                          color: isSelected
                                              ? AppColors.secondary
                                              : AppColors.secondary,
                                        ),
                                      ),
                                      backgroundColor: AppColors.white,
                                      selectedColor:
                                          AppColors.brandColor.brandColor25,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors
                                                  .neutral.neutralColor600,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        controller
                                            .toggleWalletSelection(wallet);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        }),
                        SizedBox(height: 24),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: LoadingAnimationWidget.flickr(
                                leftDotColor: AppColors.primary,
                                rightDotColor: AppColors.secondary,
                                size: 20,
                              ),
                            );
                          } else {
                            return Button(
                              label: "Create Wallet",
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.createPlan();
                              },
                            );
                          }
                        }),
                      ],
                    ),
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
