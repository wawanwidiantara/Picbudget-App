import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/register/views/personal_data_view.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Form(
      key: controller.registerFormKey,
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
                    const SizedBox(height: 16),
                    const Text('Daftar.',
                        style: TextStyle(
                            fontSize: 28,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SvgPicture.asset("assets/images/regis.svg"),
                    const SizedBox(height: 24),
                    const Text('Email',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    SizedBox(
                      child: TextFormField(
                          style: const TextStyle(
                              color: AppColors.primaryBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            hintText: 'Masukkan email Anda',
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
                    const SizedBox(height: 16),
                    const Text('Kata sandi',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    SizedBox(
                      // height: 36,
                      child: TextFormField(
                          style: const TextStyle(
                              color: AppColors.primaryBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            hintText: 'Masukkan kata sandi Anda',
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
                            Get.to(() => const PersonalDataView());
                          },
                          child: const Text("Selanjutnya",
                              style: TextStyle(
                                  color: AppColors.mainBackground,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Sudah punya akun? ',
                          style: const TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <InlineSpan>[
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryBlack),
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
        ),
      ),
    );
  }
}
