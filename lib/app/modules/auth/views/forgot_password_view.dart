import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 64,
                ),
                SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset(
                      "assets/images/picbudget logo primary.png",
                    )),
                SizedBox(height: 24),
                Text(
                  'Forgot Your Password',
                  textAlign: TextAlign.center,
                  style: AppTypography.titleLarge
                      .copyWith(height: 1.2, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                Text(
                  "Please enter the email address you'd like your password reset information sent to",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(height: 1.2),
                ),
                SizedBox(height: 24),
                FormWidget(
                    controller: controller.emailController,
                    label: '',
                    hintText: 'Enter your email',
                    isObsecured: false,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    }),
                SizedBox(height: 24),
                Button(
                  onPressed: () {
                    controller.requestResetLink();
                  },
                  label: "Request reset link",
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Get.offAll(() => LoginView());
                  },
                  child: Text(
                    'Back to login',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
