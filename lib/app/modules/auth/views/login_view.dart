import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/auth/controllers/login_controller.dart';
import 'package:picbudget_app/app/modules/auth/views/register_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                  'Sign in to your Account',
                  style: AppTypography.displaySmall
                      .copyWith(fontWeight: FontWeight.bold, height: 1.2),
                ),
                SizedBox(height: 24),
                Text(
                  'Enter your email dan password to log in\nto your account',
                  style: AppTypography.bodyMedium.copyWith(height: 1.2),
                ),
                SizedBox(height: 24),
                FormWidget(
                    controller: controller.emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    isObsecured: false,
                    keyboardType: TextInputType.emailAddress,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                SizedBox(height: 24),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot your password?',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Button(
                    onPressed: () {
                      Get.offAll(LoginView());
                    },
                    label: 'Get started now'),
                SizedBox(height: 24),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTypography.bodyMedium,
                      children: <InlineSpan>[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const RegisterView());
                            },
                            child: Text(
                              'Sign up',
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
