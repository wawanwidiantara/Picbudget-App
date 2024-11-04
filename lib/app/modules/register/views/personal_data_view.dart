import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/register/controllers/register_controller.dart';
import 'package:picbudget_app/app/modules/register/views/register_success_view.dart';

class PersonalDataView extends GetView<RegisterController> {
  const PersonalDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerDetailsFormKey,
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
                    // SvgPicture.asset("assets/images/regis.svg"),
                    const Text('Jadikan PicBudget milikmu!',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 24),
                    const Text('Nama lengkap',
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
                            hintText: 'Masukkan nama lengkap Anda',
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
                    const Text('Tanggal lahir',
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
                          autofocus: false,
                          onTap: () {
                            // controller.selectDate(context);
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 24),
                              onPressed: () {
                                // controller.selectDate(context);
                              },
                              icon: const Icon(Icons.calendar_today_rounded,
                                  color: AppColors.primaryBlack),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            hintText: 'DD/MM/YYYY',
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
                    const Text('Jenis kelamin',
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryBlack,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField(
                      hint: const Text("Pilih jenis kelamin",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w500)),
                      items: const [
                        DropdownMenuItem(
                          value: "Laki-laki",
                          child: Text("Laki-laki"),
                        ),
                        DropdownMenuItem(
                          value: "Perempuan",
                          child: Text("Perempuan"),
                        ),
                      ],
                      onChanged: (value) {
                        // controller.selectDate(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
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
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Nomor Telp. Aktif',
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
                          keyboardType: TextInputType.phone,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            hintText: '+628xxxxxx',
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
                            Get.offAll(() => const RegisterSuccessView());
                          },
                          child: const Text("Registrasi",
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
