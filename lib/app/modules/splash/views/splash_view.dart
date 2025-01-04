import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background-primary.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 10,
              ),
            ),
            SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  "assets/images/picbudget logo.png",
                )),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'PicBudget.',
                style: AppTypography.displaySmall.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 10,
              ),
            ),
            Center(
              child: Text(
                'powered by',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'clowd',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
