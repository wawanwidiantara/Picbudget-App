import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final getStorage = GetStorage();
  final RxBool isLoading = false.obs;
  
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

      isLoading.value = true;
      try {
        final response = await http.post(
          Uri.parse('${UrlApi.baseAPI}/api/auth/login/'),
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

          await authService.saveTokens(data['access'], data['refresh']);

          getStorage.write('user', data['data']);

          SnackBarWidget.showSnackBar(
            'Login Success',
            'Welcome back!',
            'success',
          );

          Get.offAllNamed(Routes.NAVBAR);
        } else {
          SnackBarWidget.showSnackBar(
            'Login Failed',
            'Invalid email or password',
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
