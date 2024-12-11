import 'package:get/get.dart';

import '../controllers/picocr_controller.dart';

class PicocrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PicocrController>(
      () => PicocrController(),
    );
  }
}
