import 'package:get/get.dart';

import 'package:picbudget_app/app/modules/picplan/controllers/create_picplan_controller.dart';

import '../controllers/picplan_controller.dart';

class PicplanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePicplanController>(
      () => CreatePicplanController(),
    );
    Get.lazyPut<PicplanController>(
      () => PicplanController(),
    );
  }
}
