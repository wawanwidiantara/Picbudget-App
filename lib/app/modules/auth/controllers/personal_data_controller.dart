import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/modules/auth/views/personal_data_success_view.dart';

class PersonalDataController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final isAgree = false.obs;
  final isLoading = false.obs;

  final AuthService authService = AuthService();

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
      final user = storage.read('user');
      final userId = user?['id'];

      if (token == null || userId == null) {
        SnackBarWidget.showSnackBar(
          'Error',
          'User authentication data is missing. Please log in again.',
          'err',
        );
        return;
      }

      isLoading.value = true;
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
          SnackBarWidget.showSnackBar(
            'Success',
            'Profile updated successfully.',
            'success',
          );
          Get.offAll(() => PersonalDataSuccessView());
        } else if (response.statusCode == 401) {
          final refreshToken = storage.read('refresh');
          if (refreshToken != null && await authService.checkAuthState()) {
            await saveProfile();
          } else {
            SnackBarWidget.showSnackBar(
              'Error',
              'Session expired. Please log in again.',
              'err',
            );
            GetStorage().erase();
          }
        } else {
          final errorData = jsonDecode(response.body);
          SnackBarWidget.showSnackBar(
            'Error',
            errorData['message'] ??
                'Failed to update profile. Please try again.',
            'err',
          );
        }
      } catch (e) {
        SnackBarWidget.showSnackBar(
          'Error',
          'Something went wrong. Please try again later.',
          'err',
        );
      } finally {
        isLoading.value = false;
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
