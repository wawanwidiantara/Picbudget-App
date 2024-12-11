import 'package:get/get.dart';

import '../controllers/picreport_controller.dart';

class PicreportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PicreportController>(
      () => PicreportController(),
    );
  }
}
