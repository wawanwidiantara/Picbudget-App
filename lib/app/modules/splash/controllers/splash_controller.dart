import 'package:get/get.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.ON_BOARDING);
    });
    // var loginStatus = false;
    // if (loginStatus) {
    //   Future.delayed(const Duration(seconds: 3), () {
    //     Get.offAllNamed(Routes.HOME);
    //   });
    // } else {
    //   Future.delayed(const Duration(seconds: 3), () {
    //     Get.offAllNamed(Routes.ON_BOARDING);
    //   });
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
