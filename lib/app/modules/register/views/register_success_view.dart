import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/register/views/register_balance_view.dart';

class RegisterSuccessView extends GetView {
  const RegisterSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/initialbalances.svg"),
                const SizedBox(height: 8),
                SvgPicture.asset("assets/icons/success.svg"),
                const SizedBox(height: 24),
                const Text(
                  'Registrasi Berhasil!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                    'PicBudget bakal scan struk belanjaan kamu secara otomatis! Ayo, tentuin saldo awal biar trackingnya makin akurat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlack,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Get.offAll(const RegisterBalanceView());
                      },
                      child: const Text("Ayo Mulai!",
                          style: TextStyle(
                              color: AppColors.mainBackground,
                              fontSize: 14,
                              fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          ),
        ));
  }
}
