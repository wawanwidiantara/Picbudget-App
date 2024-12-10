import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  final countdown = 30.obs;
  Timer? timer;
  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void startCountdown() {
    countdown.value = 30;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> resendOTP() async {
    // Logic for resending OTP goes here
    startCountdown();
  }

  Future<void> verifyOtp() async {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(Routes.ON_BOARDING);
    }
  }
}
