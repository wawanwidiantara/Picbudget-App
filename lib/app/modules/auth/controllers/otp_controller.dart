import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/modules/auth/views/register_success_view.dart';

class OtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();

  final countdown = 30.obs;
  final isLoading = false.obs;

  Timer? timer;
  final argument = Get.arguments;

  final AuthService authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    startCountdown();
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
    if (argument["email"] == null || argument["email"]!.isEmpty) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Email is missing. Cannot resend OTP.',
        'err',
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/auth/resend-otp/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': argument["email"]}),
      );

      if (response.statusCode == 200) {
        SnackBarWidget.showSnackBar(
          'Success',
          'OTP has been resent to your email.',
          'success',
        );
        startCountdown();
      } else {
        final errorData = jsonDecode(response.body);
        SnackBarWidget.showSnackBar(
          'Error',
          errorData['message'] ?? 'Failed to resend OTP. Please try again.',
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
  }

  Future<void> verifyOtp() async {
    if (formKey.currentState!.validate()) {
      final String otpCode = otpController.text.trim();

      isLoading.value = true;
      try {
        final response = await http.post(
          Uri.parse('${UrlApi.baseAPI}/api/auth/verify-otp/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': argument["email"],
            'otp_code': otpCode,
          }),
        );

        if (response.statusCode == 200) {
          final loginResponse = await http.post(
            Uri.parse('${UrlApi.baseAPI}/api/auth/login/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': argument["email"],
              'password': argument["password"],
            }),
          );

          if (loginResponse.statusCode == 200) {
            final data = jsonDecode(loginResponse.body);

            await authService.saveTokens(data['access'], data['refresh']);
            GetStorage().write('user', data['data']);

            SnackBarWidget.showSnackBar(
              'Success',
              'OTP verified and logged in successfully.',
              'success',
            );

            Get.offAll(() => RegisterSuccessView());
          } else {
            SnackBarWidget.showSnackBar(
              'Login Failed',
              'Unable to log in after OTP verification. Please try again.',
              'err',
            );
          }
        } else {
          final errorData = jsonDecode(response.body);
          SnackBarWidget.showSnackBar(
            'Verification Failed',
            errorData['message'] ?? 'Invalid OTP. Please try again.',
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
    }
  }
}
