import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picbudget_app/app/modules/auth/views/personal_data_success_view.dart';

class PersonalDataController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final isAgree = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveProfile() async {
    if (formKey.currentState!.validate() && isAgree.value) {
      Get.offAll(() => PersonalDataSuccessView());
    }
  }
}
