import 'package:get/get.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    bool isAuthenticated = await _authService.checkAuthState();
    
    Future.delayed(Duration(seconds: 3), () {
      if (isAuthenticated) {
        Get.offAllNamed(Routes.NAVBAR); 
      } else {
        Get.offAllNamed(Routes.ON_BOARDING); 
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
