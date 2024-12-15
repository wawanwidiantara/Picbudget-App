import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/auth/views/personal_data_view.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class RegisterSuccessView extends GetView {
  const RegisterSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/register-success.svg"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Button(
                    label: 'Skip',
                    type: ButtonType.tertiary,
                    onPressed: () {
                      Get.offAllNamed(Routes.NAVBAR);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                    child: Button(
                  type: ButtonType.secondary,
                  label: 'Add Details',
                  onPressed: () {
                    Get.offAll(() => PersonalDataView());
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
