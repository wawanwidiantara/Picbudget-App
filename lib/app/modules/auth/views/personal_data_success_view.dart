import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/buttons.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class PersonalDataSuccessView extends GetView {
  const PersonalDataSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background-secondary.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        "assets/images/picbudget logo white.png",
                      )),
                  SizedBox(width: 8),
                  Text(
                    'PicBudget',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: Get.height * 0.3,
                width: Get.width,
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Profile Completed!',
                            textAlign: TextAlign.center,
                            style: AppTypography.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Your details have been saved successfully. PicBudget is now ready to provide you with smarter, personalized financial insights!',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyMedium.copyWith(
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      Button(
                        label: 'Go to Home',
                        type: ButtonType.secondary,
                        onPressed: () {
                          Get.offAllNamed(Routes.NAVBAR);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
