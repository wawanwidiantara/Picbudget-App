import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/core/styles/form_styles.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/create_wallet_controller.dart';

class CreateWalletView extends GetView<CreateWalletController> {
  const CreateWalletView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateWalletController());
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
                      'Wallet',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.account_balance_wallet,
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
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Image.asset(
                                    "assets/images/picbudget logo primary.png",
                                  )),
                              SizedBox(height: 24),
                              Obx(() {
                                return Text(
                                  controller.isEditMode.value
                                      ? 'Update Wallet'
                                      : 'Create Wallet',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.titleLarge.copyWith(
                                      height: 1.2, fontWeight: FontWeight.bold),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        FormWidget(
                            controller: controller.nameController,
                            label: 'Wallet name',
                            hintText: 'Enter wallet name',
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Wallet type",
                                style: AppTypography.titleSmall),
                            SizedBox(height: 8),
                            Obx(
                              () {
                                return DropdownButtonFormField(
                                  value:
                                      controller.selectedType.value.isNotEmpty
                                          ? controller.selectedType.value
                                          : null, // Bind reactive variable
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select your wallet type';
                                    }
                                    return null;
                                  },
                                  dropdownColor: AppColors.white,
                                  hint: Text(
                                    "Select your wallet type",
                                    style: AppTypography.bodyMedium.copyWith(
                                        color:
                                            AppColors.neutral.neutralColor700),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: "cash",
                                      child: Text(
                                        "Cash",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "bank",
                                      child: Text(
                                        "Bank",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "ewallet",
                                      child: Text(
                                        "E-Wallet",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.selectedType.value =
                                        value.toString();
                                  },
                                  decoration: dropDownFormStyle(),
                                );
                              },
                            ),
                          ],
                        ),
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
                              label: controller.isEditMode.value
                                  ? "Update Wallet"
                                  : "Create Wallet",
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                controller.createOrUpdateWallet();
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
