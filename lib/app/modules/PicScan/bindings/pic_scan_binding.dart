import 'package:get/get.dart';

import 'package:picbudget_app/app/modules/PicScan/controllers/extract_receipt_controller.dart';

import '../controllers/pic_scan_controller.dart';

class PicScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtractReceiptController>(
      () => ExtractReceiptController(),
    );
    Get.lazyPut<PicScanController>(
      () => PicScanController(),
    );
  }
}
