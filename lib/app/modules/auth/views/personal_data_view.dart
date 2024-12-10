import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/core/styles/form_styles.dart';
import 'package:picbudget_app/app/modules/auth/controllers/personal_data_controller.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class PersonalDataView extends GetView<PersonalDataController> {
  const PersonalDataView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalDataController());
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Personal Data',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(height: 24),
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
                            FormWidget(
                              controller: controller.fullnameController,
                              label: "Fullname",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Fullname is required';
                                }
                                return null;
                              },
                              isObsecured: false,
                              keyboardType: TextInputType.text,
                              hintText: "Enter your fullname",
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender", style: AppTypography.titleSmall),
                                SizedBox(height: 8),
                                DropdownButtonFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Gender is required';
                                    }
                                    return null;
                                  },
                                  dropdownColor: AppColors.white,
                                  hint: Text(
                                    "Select your gender",
                                    style: AppTypography.bodyMedium.copyWith(
                                        color:
                                            AppColors.neutral.neutralColor700),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: "male",
                                      child: Text(
                                        "Male",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: "female",
                                      child: Text(
                                        "Perempuan",
                                        style: AppTypography.bodyMedium
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.genderController.text =
                                        value.toString();
                                  },
                                  decoration: dropDownFormStyle(),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            FormWidget(
                              controller: controller.ageController,
                              label: "Age",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Age is required';
                                }
                                return null;
                              },
                              isObsecured: false,
                              keyboardType: TextInputType.number,
                              hintText: "Enter your age",
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 24),
                            FormWidget(
                              controller: controller.phoneController,
                              label: "Phone number",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone number is required';
                                }
                                return null;
                              },
                              isObsecured: false,
                              keyboardType: TextInputType.phone,
                              hintText: "Enter your phone number",
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 12),
                            // checkboxes
                            Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.isAgree.value,
                                    onChanged: (value) {
                                      controller.isAgree.value = value!;
                                    },
                                    splashRadius: 1,
                                    checkColor: AppColors.secondary,
                                    fillColor: WidgetStateProperty.all(
                                        AppColors.white),
                                    activeColor: AppColors.secondary,
                                    focusColor: AppColors.secondary,
                                    overlayColor: WidgetStateProperty.all(
                                      AppColors.secondary,
                                    ),
                                    hoverColor: AppColors.secondary,
                                  );
                                }),
                                Text.rich(
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: AppTypography.bodyMedium,
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        alignment:
                                            PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: GestureDetector(
                                          onTap: () {
                                            termCondition(context);
                                          },
                                          child: Text(
                                            'Terms and Conditions',
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                              color: AppColors.secondary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Button(
                              label: "Save My Details",
                              type: ButtonType.secondary,
                              onPressed: () {
                                controller.saveProfile();
                              },
                            ),
                            SizedBox(height: 24),
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  text: "Don't want to fill this now? ",
                                  style: AppTypography.bodyMedium,
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.offAllNamed(Routes.NAVBAR);
                                        },
                                        child: Text(
                                          'Skip for now',
                                          style:
                                              AppTypography.bodyMedium.copyWith(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                          // TextFormField(
                          //   decoration: InputDecoration(
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> termCondition(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Terms and Conditions',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Effective Date: [Insert Date]',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Welcome to PicBudget, your AI-powered money management app. By using PicBudget, you agree to comply with and be bound by the following terms and conditions ("Terms"). Please read them carefully before accessing or using the app. If you do not agree to these Terms, please do not use the app.',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 16.0),
                Text(
                  '1. Acceptance of Terms',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'By accessing or using PicBudget, you accept these Terms and our Privacy Policy, which governs how we collect, use, and protect your personal data. If you do not agree to these Terms, discontinue use immediately.',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 16.0),
                Text(
                  '2. Eligibility',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'You must be at least 18 years old to use PicBudget. By registering, you confirm that you meet this age requirement.',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 16.0),
                Text(
                  '3. Personal Data Collection',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'To provide our services effectively, PicBudget collects the following personal data:',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 8.0),
                Text(
                  '• Personal Identification Information: Name, email address, phone number, and other contact details.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• Financial Data: Income, expenses, bank transactions, savings goals, and budgets.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• Behavioral Data: App usage patterns, preferences, and interactions.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• Device Data: IP address, device type, operating system, and browser information.',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 16.0),
                Text(
                  '4. How We Use Your Data',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'PicBudget uses your personal data for the following purposes:',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 8.0),
                Text(
                  '• To analyze and provide personalized financial insights.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• To generate AI-powered budgeting recommendations.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• To improve the app\'s functionality and user experience.',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• To communicate important updates and promotional content (with your consent).',
                  style: AppTypography.bodyMedium,
                ),
                Text(
                  '• To ensure compliance with legal and regulatory requirements.',
                  style: AppTypography.bodyMedium,
                ),
                SizedBox(height: 16.0),
                Text(
                  '5. Data Sharing and Protection',
                  style: AppTypography.bodyMedium
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '• Third-Party Sharing: We may share your data with trusted third-party service providers, such as payment processors or analytics providers, solely to deliver our services effectively.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.secondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
