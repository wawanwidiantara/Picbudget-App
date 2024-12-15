import 'package:get/get.dart';

import '../controllers/picplan_controller.dart';

class PicplanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PicplanController>(
      () => PicplanController(),
    );
  }
}
