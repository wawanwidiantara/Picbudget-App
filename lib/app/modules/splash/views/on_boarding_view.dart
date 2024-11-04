import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class OnBoardingView extends GetView {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        LiquidSwipe(
          fullTransitionValue: 400,
          enableLoop: false,
          pages: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.primaryBlack,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Foto struk, PicBudget yang urus!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text(
                      'Fotoin aja strukmu, sisanya biar PicBudget yang kelarin. Canggih kan teknologinya?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(height: 16),
                  SvgPicture.asset("assets/images/intro1.svg"),
                  const SizedBox(height: 64),
                  const Text('Geser ke kiri untuk melanjutkan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.mainBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/intro2.svg"),
                  const SizedBox(height: 32),
                  const Text('Budget sesuai maumu!',
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text(
                      'PicBudget bantu kamu bagiin budget sesuai kebutuhanmu. Jadi gampang ngatur keuangan!',
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(height: 64),
                  const Text('Geser ke kiri untuk melanjutkan',
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.normal))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Pengeluaran jadi keliatan jelas',
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text(
                      'PicBudget kasih laporan harian biar kamu ngerti pola belanja. Bisa tau dimana harus ngirit, dan apa yang perlu diapresiasi.',
                      style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(height: 16),
                  SvgPicture.asset("assets/images/intro3.svg"),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlack,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: const Text("Mulai",
                            style: TextStyle(
                                color: AppColors.mainBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
