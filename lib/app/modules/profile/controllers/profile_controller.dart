import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> logout() async {
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
      return;
    }

    try {
      // Send POST request to logout endpoint
      final response = await http.post(
        Uri.parse('${UrlApi.baseAPI}/api/auth/logout/'),
        headers: {
          'Authorization':
              'Bearer $accessToken', // Pass access token in the header
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'refresh': refreshToken}),
      );

      if (response.statusCode < 300) {
        // Successfully logged out
        SnackBarWidget.showSnackBar(
          'Success',
          'You have been logged out successfully.',
          'success',
        );

        // Clear user data from GetStorage
        storage.erase();

        // Navigate to LoginView
        Get.offAll(() => const LoginView());
      } else if (response.statusCode == 401) {
        // Handle 401 Unauthorized
        SnackBarWidget.showSnackBar(
          'Session Expired',
          'Your session is invalid or account is removed. Please log in again.',
          'err',
        );

        // Clear user data from GetStorage
        storage.erase();

        // Navigate to LoginView
        Get.offAll(() => const LoginView());
      } else {
        // Handle other error responses
        final errorData = jsonDecode(response.body);
        SnackBarWidget.showSnackBar(
          'Error',
          errorData['message'] ?? 'Failed to log out. Please try again.',
          'err',
        );
      }
    } catch (e) {
      // Handle unexpected errors
      SnackBarWidget.showSnackBar(
        'Error',
        'Something went wrong. Please try again later.',
        'err',
      );
    }
  }
}
