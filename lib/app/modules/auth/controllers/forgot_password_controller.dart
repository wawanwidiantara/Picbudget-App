import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();




  Future<void> requestResetLink() async {
    if (formKey.currentState!.validate()) {
      final String email = emailController.text.trim();

      try {
        // Make the POST request
        final response = await http.post(
          Uri.parse(
              '${UrlApi.baseAPI}/api/auth/password-reset/'), // Use UrlApi.baseAPI
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'email': email}),
        );

        if (response.statusCode <= 200) {
          // Show success snackbar
          SnackBarWidget.showSnackBar(
            'Code Sent',
            'Please check your email for the reset code',
            'success',
          );

          // Navigate to the home page
          Get.offAll(() => LoginView());
        } else {
          // Handle error
          SnackBarWidget.showSnackBar(
            'Error',
            'Something went wrong. Please try again later.',
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
