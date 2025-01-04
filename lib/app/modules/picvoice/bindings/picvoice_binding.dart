import 'package:get/get.dart';

import '../controllers/picvoice_controller.dart';

class PicvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PicvoiceController>(
      () => PicvoiceController(),
    );
  }
}
