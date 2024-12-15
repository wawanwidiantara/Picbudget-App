import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
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
  void onClose() {
    fullnameController.dispose();
    genderController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> saveProfile() async {
    if (formKey.currentState!.validate() && isAgree.value) {
      final storage = GetStorage();
      final token = storage.read('access');
      final userId = storage
          .read('user')['id']; // Assuming 'user' is stored with 'id' key.

      if (token == null || userId == null) {
        SnackBarWidget.showSnackBar(
          'Error',
          'User authentication data is missing. Please log in again.',
          'err',
        );
        return;
      }

      try {
        final url = Uri.parse('${UrlApi.baseAPI}/api/account/$userId/');
        final response = await http.put(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'full_name': fullnameController.text.trim(),
            'gender': genderController.text.trim(),
            'age': ageController.text.trim(),
            'phone_number': phoneController.text.trim(),
          }),
        );

        if (response.statusCode == 200) {
          // Successfully updated profile
          SnackBarWidget.showSnackBar(
            'Success',
            'Profile updated successfully.',
            'success',
          );
          Get.offAll(() => PersonalDataSuccessView());
        } else {
          // Error response
          final errorData = jsonDecode(response.body);
          SnackBarWidget.showSnackBar(
            'Error',
            errorData['message'] ??
                'Failed to update profile. Please try again.',
            'err',
          );
        }
      } catch (e) {
        // Handle network or unexpected errors
        SnackBarWidget.showSnackBar(
          'Error',
          'Something went wrong. Please try again later.',
          'err',
        );
      }
    } else if (!isAgree.value) {
      SnackBarWidget.showSnackBar(
        'Error',
        'You must agree to the terms and conditions to proceed.',
        'err',
      );
    }
  }
}
