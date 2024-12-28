import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:password_strength/password_strength.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/modules/auth/views/otp_view.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final passwordStrength = 0.obs;
  final isLoading = false.obs; // Add loading state

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(() => evaluatePasswordStrength());
  }

  void evaluatePasswordStrength() {
    final password = passwordController.text;
    double strength = estimatePasswordStrength(password);

    if (password.isEmpty) {
      passwordStrength.value = 0;
    } else if (strength <= 0.25) {
      passwordStrength.value = 1;
    } else if (strength > 0.25 && strength <= 0.5) {
      passwordStrength.value = 2;
    } else if (strength > 0.5 && strength <= 0.75) {
      passwordStrength.value = 3;
    } else if (strength > 0.75) {
      passwordStrength.value = 4;
    }
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String confirmPassword = confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        SnackBarWidget.showSnackBar(
          'Error',
          'Passwords do not match',
          'err',
        );
        return;
      }

      isLoading.value = true; // Start loading
      try {
        final response = await http.post(
          Uri.parse('${UrlApi.baseAPI}/api/auth/register/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body);

          SnackBarWidget.showSnackBar(
            'Success',
            data['message'],
            'success',
          );

          Get.to(() => OtpView(), arguments: {
            'email': email,
            'password': password,
          });
        } else {
          final errorData = jsonDecode(response.body);
          SnackBarWidget.showSnackBar(
            'Registration Failed',
            errorData['email'][0] ?? 'An error occurred. Please try again.',
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
        isLoading.value = false; // End loading
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}