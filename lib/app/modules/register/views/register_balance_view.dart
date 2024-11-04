import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/register/controllers/register_controller.dart';

class RegisterBalanceView extends GetView<RegisterController> {
  const RegisterBalanceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.balanceFormKey,
      child: Scaffold(
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(
          child: SizedBox(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    const Text('Jumlah Uang di Dompet.',
                        style: TextStyle(
                            fontSize: 28,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text(
                        'Lupakan kalkulasi kasar! Masukkan saldo awal untuk pelacakan anggaran yang presisi.',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 32),
                    SizedBox(
                      child: TextFormField(
                          style: const TextStyle(
                              color: AppColors.primaryBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            hintText: 'Masukkan saldo Anda',
                            hintStyle: const TextStyle(
                                color: AppColors.greyText,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: AppColors.formFill,
                            focusColor: AppColors.mainBackground,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.primaryBlack, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.formFill),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
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
                            // Get.offAllNamed(Routes.NAVBAR);
                          },
                          child: const Text("Siap Mengatur Keuangan!",
                              style: TextStyle(
                                  color: AppColors.mainBackground,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
