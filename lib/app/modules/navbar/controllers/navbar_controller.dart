import 'package:get/get.dart';

class NavbarController extends GetxController {
  var tabIndex = 0;
  var idTab = Get.arguments;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    update();
  }

  @override
  void onReady() {
    if (idTab == null) {
      changeTabIndex(tabIndex);
    } else {
      changeTabIndex(idTab);
    }
    super.onReady();
    update();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
