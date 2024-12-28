import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/auth/controllers/register_controller.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          "assets/images/picbudget logo primary.png",
                        )),
                    SizedBox(width: 8),
                    Text(
                      'PicBudget',
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Create Your PicBudget Account',
                  style: AppTypography.displaySmall
                      .copyWith(fontWeight: FontWeight.bold, height: 1.2),
                ),
                SizedBox(height: 24),
                Text(
                  'Your First Step Towards Smarter Financial\n Management!',
                  style: AppTypography.bodyMedium.copyWith(height: 1.2),
                ),
                SizedBox(height: 24),
                FormWidget(
                    controller: controller.emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    isObsecured: false,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
                SizedBox(height: 24),
                FormWidget(
                    controller: controller.passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    isObsecured: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      controller.evaluatePasswordStrength();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                SizedBox(height: 24),
                Obx(() {
                  final strength = controller.passwordStrength.value;
                  return Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                          color: index < strength
                              ? (strength == 1
                                  ? AppColors.error.errorColor500
                                  : strength == 2
                                      ? AppColors.primary
                                      : AppColors.success.successColor500)
                              : AppColors.neutral.neutralColor700,
                        ),
                      );
                    }),
                  );
                }),
                SizedBox(height: 24),
                FormWidget(
                    controller: controller.confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Enter your password again',
                    isObsecured: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
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
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.register();
                        },
                        label: 'Register');
                  }
                }),
                SizedBox(height: 24),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: AppTypography.bodyMedium,
                      children: <InlineSpan>[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAll(LoginView());
                            },
                            child: Text(
                              'Log in',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
