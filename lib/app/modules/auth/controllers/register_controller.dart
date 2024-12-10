import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_strength/password_strength.dart';
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

    // Update the strength value based on the calculated strength score
    if (password.isEmpty) {
      passwordStrength.value = 0; // No bar (or all grey)
    } else if (strength <= 0.25) {
      passwordStrength.value = 1; // Weak (Red)
    } else if (strength > 0.25 && strength <= 0.5) {
      passwordStrength.value = 2; // Moderate (Yellow)
    } else if (strength > 0.5 && strength <= 0.75) {
      passwordStrength.value = 3; // Strong (Light Green)
    } else if (strength > 0.75) {
      passwordStrength.value = 4; // Very Strong (Full Green)
    }
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      Get.offAll(() => OtpView());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
