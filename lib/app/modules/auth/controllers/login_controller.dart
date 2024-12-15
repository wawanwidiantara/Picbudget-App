import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final getStorage = GetStorage();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      try {
        // Make the POST request
        final response = await http.post(
          Uri.parse('${UrlApi.baseAPI}/api/auth/login/'), // Use UrlApi.baseAPI
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          // Save tokens and user data in GetStorage
          getStorage.write('refresh', data['refresh']);
          getStorage.write('access', data['access']);
          getStorage.write('user', data['data']);

          // Show success snackbar
          SnackBarWidget.showSnackBar(
            'Login Success',
            'Welcome back!',
            'success',
          );

          // Navigate to the home page
          Get.offAllNamed(Routes.NAVBAR);
        } else {
          // Handle error
          SnackBarWidget.showSnackBar(
            'Login Failed',
            'Invalid email or password',
            'err',
          );
        }
      } catch (e) {
        // Handle other errors
        SnackBarWidget.showSnackBar(
          'Error',
          'Something went wrong. Please try again later.',
          'err',
        );
      }
    }
  }
}

