import 'dart:convert';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/url.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/modules/login/controllers/login_controller.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';
import 'package:picbudget_app/app/widget/snackbar.dart';

class ProfileController extends GetxController {
  final loginController = Get.put(LoginController());
  var user = {}.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    var data = loginController.getStorage.read('user');
    if (data != null) {
      user.value = data;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() {
    isLoading(true);
    var url = Uri.parse("${UrlApi.baseAPI}/logout/");
    var token = 'Bearer ${loginController.getStorage.read("access_token")}';
    var refresh = loginController.getStorage.read('refresh_token');
    var inputLogout = json.encode({
      'refresh_token': refresh,
    });
    http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: inputLogout,
    )
        .then((response) {
      if (response.statusCode == 205) {
        isLoading(false);
        SnackBarWidget.showSnackBar(
          'Logout Berhasil',
          'Anda telah berhasil keluar ke akun Anda',
          'Success',
        );
        loginController.getStorage.erase();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        isLoading(false);
        SnackBarWidget.showSnackBar(
          'Logout Gagal',
          'Terjadi kesalahan saat keluar dari akun Anda',
          'err',
        );
      }
    });
  }
}
