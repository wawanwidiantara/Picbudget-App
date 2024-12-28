import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:picbudget_app/app/core/components/forms.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/auth/controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController());
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
                  'Enter Verification Code',
                  textAlign: TextAlign.center,
                  style: AppTypography.titleLarge
                      .copyWith(height: 1.2, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                Text(
                  'The verification code has been sent via Email to\ngdwidi13@gmail.com',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(height: 1.2),
                ),
                SizedBox(height: 24),
                OTPForm(
                  controller: controller.otpController,
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.verifyOtp();
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the OTP';
                    }
                    return null;
                  },
                ),
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
                    if (controller.countdown.value > 0) {
                      return Text(
                        'Please wait ${controller.countdown.value} seconds to resend',
                        style: AppTypography.bodyMedium,
                      );
                    } else {
                      return Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Didn't receive the code? ",
                            style: AppTypography.bodyMedium,
                            children: <InlineSpan>[
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: GestureDetector(
                                  onTap: controller.resendOTP,
                                  child: Text(
                                    'Resend',
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
                      );
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
