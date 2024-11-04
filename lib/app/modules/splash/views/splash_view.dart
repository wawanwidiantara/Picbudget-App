import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
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
          const Center(
            child: Text(
              'PicBudget.',
              style: TextStyle(
                  fontSize: 38,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 10,
            ),
          ),
          const Center(
            child: Text(
              'powered by',
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Center(
            child: Text(
              'clowd',
              style: TextStyle(
                  fontSize: 30,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
