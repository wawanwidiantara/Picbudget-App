import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final isLoading = false.obs;
  final user = {}.obs;

  @override
  void onInit() {
    final userData = GetStorage().read('user');
    if (userData != null) {
      user.value = userData;
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> logout() async {
    isLoading.value = true;
    final storage = GetStorage();
    final refreshToken = storage.read('refresh');
    final accessToken = storage.read('access');

    if (refreshToken == null || accessToken == null) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Authentication tokens are missing. Please log in again.',
        'err',
      );
      Get.offAll(() => const LoginView());
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/auth/logout/'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        SnackBarWidget.showSnackBar(
          'Success',
          'You have been logged out successfully.',
          'success',
        );
        storage.erase();
        Get.offAll(() => const LoginView());
      } else if (response.statusCode == 401) {
        bool refreshed = await _authService.checkAuthState();
        if (refreshed) {
          await logout();
        } else {
          SnackBarWidget.showSnackBar(
            'Session Expired',
            'Your session is invalid or account is removed. Please log in again.',
            'err',
          );
          storage.erase();
          Get.offAll(() => LoginView());
        }
      } else {
        final errorData = jsonDecode(response.body);
        SnackBarWidget.showSnackBar(
          'Error',
          errorData['message'] ?? 'Failed to log out. Please try again.',
          'err',
        );
      }
      storage.erase();
      Get.offAll(() => const LoginView());
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Something went wrong. Please try again later.',
        'err',
      );
      storage.erase();
      Get.offAll(() => const LoginView());
    } finally {
      isLoading.value = false;
    }
  }
}
