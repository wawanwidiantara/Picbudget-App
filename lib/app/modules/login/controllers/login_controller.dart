import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/constans/url.dart';
import 'package:picbudget_app/app/data/models/user_model.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';
import 'package:picbudget_app/app/widget/snackbar.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final User user = User();
  final getStorage = GetStorage();
  final loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController, passwordController;
  var email = '';
  var password = '';
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    return null;
  }

  login(String email, String password) {
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      isLoading(true);
      var url = Uri.parse("${UrlApi.baseAPI}/login/");
      var inputLogin = json.encode({
        'email': email,
        'password': password,
      });
      http
          .post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: inputLogin,
      )
          .then((res) {
        if (res.statusCode == 200) {
          var response = json.decode(res.body);
          getStorage.write("access_token", response['access']);
          getStorage.write("refresh_token", response['refresh']);
          var user = User.fromJson(response['data']);
          getStorage.write('user', user.toJson());
          emailController.clear();
          passwordController.clear();
          Get.offAllNamed(Routes.NAVBAR);
          SnackBarWidget.showSnackBar(
            'Login Berhasil',
            'Selamat datang ${user.name}',
            'success',
          );
          isLoading(false);
        } else {
          SnackBarWidget.showSnackBar(
            'Login Gagal',
            'Email atau password salah',
            'err',
          );
          isLoading(false);
        }
      }).catchError((err) {
        SnackBarWidget.showSnackBar(
          'Login Gagal',
          '$err',
          'err',
        );
        isLoading(false);
      });
    }
    loginFormKey.currentState!.save();
  }
}
