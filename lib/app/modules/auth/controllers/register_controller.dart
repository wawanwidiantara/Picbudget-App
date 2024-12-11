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

  @override
  void onInit() {
    super.onInit();
    passwordController.addListener(() => evaluatePasswordStrength());
  }

  void evaluatePasswordStrength() {
    final password = passwordController.text;
    double strength = estimatePasswordStrength(password);

    if (password.isEmpty) {
      passwordStrength.value = 0; // No bar
    } else if (strength <= 0.25) {
      passwordStrength.value = 1; // Weak
    } else if (strength > 0.25 && strength <= 0.5) {
      passwordStrength.value = 2; // Moderate
    } else if (strength > 0.5 && strength <= 0.75) {
      passwordStrength.value = 3; // Strong
    } else if (strength > 0.75) {
      passwordStrength.value = 4; // Very Strong
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

      try {
        // Send POST request to register API
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

          // Show success snackbar
          SnackBarWidget.showSnackBar(
            'Success',
            data[
                'message'], // "User registered successfully. OTP sent to email."
            'success',
          );

          // Navigate to OTP View, passing email and password
          Get.to(() => OtpView(), arguments: {
            'email': email,
            'password': password,
          });
        } else {
          // Show error snackbar
          final errorData = jsonDecode(response.body);
          SnackBarWidget.showSnackBar(
            'Registration Failed',
            errorData['email'][0] ?? 'An error occurred. Please try again.',
            'err',
          );
        }
      } catch (e) {
        // Handle network or other errors
        SnackBarWidget.showSnackBar(
          'Error',
          'Something went wrong. Please try again later.',
          'err',
        );
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
