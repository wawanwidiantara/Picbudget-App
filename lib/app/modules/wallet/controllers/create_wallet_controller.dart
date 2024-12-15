import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';

class CreateWalletController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final getStorage = GetStorage();

  final walletController = Get.put(WalletController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Create a new wallet
  Future<void> createWallet() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final type = typeController.text;
      final balance = double.parse(amountController.text);

      await walletController.createWallet(name, type, balance);
      Get.back();
    }
  }
}
