import 'package:get/get.dart';

import 'package:picbudget_app/app/modules/wallet/controllers/create_wallet_controller.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/create_wallet_controller.dart';

import '../controllers/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWalletController>(
      () => CreateWalletController(),
    );
    Get.lazyPut<CreateWalletController>(
      () => CreateWalletController(),
    );
    Get.lazyPut<WalletController>(
      () => WalletController(),
    );
  }
}
