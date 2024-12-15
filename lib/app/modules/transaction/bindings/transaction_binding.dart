import 'package:get/get.dart';

import 'package:picbudget_app/app/modules/transaction/controllers/transaction_detail_controller.dart';

import '../controllers/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailController>(
      () => TransactionDetailController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
  }
}
