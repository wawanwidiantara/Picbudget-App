import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:http/http.dart' as http;

class CreateWalletController extends GetxController {
  final argument = Get.arguments;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final getStorage = GetStorage();

  final walletController = Get.put(WalletController());

  var selectedType = ''.obs;
  var isLoading = false.obs;
  var isEditMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      isEditMode.value = true;
      loadWalletData(argument);
    }
  }



  Future<void> loadWalletData(String walletId) async {
    isLoading.value = true;
    try {
      await walletController.fetchWalletDetail(walletId);
      final wallet = walletController.selectedWallet.value;

      nameController.text = wallet["name"] ?? '';
      amountController.text = wallet["balance"]?.toString() ?? '';
      selectedType.value = wallet["type"] ?? '';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrUpdateWallet() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    try {
      final token = getStorage.read('access');
      Uri url;

      Map<String, dynamic> body = {
        if (nameController.text.isNotEmpty) "name": nameController.text,
        if (amountController.text.isNotEmpty)
          "balance": double.tryParse(amountController.text),
        if (selectedType.isNotEmpty) "type": selectedType.value,
      };

      if (isEditMode.value) {
        url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$argument/");
        final response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );
        if (response.statusCode == 200) {
          walletController.fetchWallets();
          walletController.fetchTotalBalance();
          Get.back();
          SnackBarWidget.showSnackBar(
              "Success", "Wallet updated successfully.", "success");
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to update wallet. Status: ${response.statusCode}",
            "err",
          );
        }
      } else {
        url = Uri.parse("${UrlApi.baseAPI}/api/wallets/");
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );

        if (response.statusCode == 201) {
          walletController.fetchWallets();
          walletController.fetchTotalBalance();
          Get.back();
          SnackBarWidget.showSnackBar(
              "Success", "Wallet created successfully.", "success");
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to create wallet. Status: ${response.statusCode}",
            "err",
          );
        }
      }
    } catch (e) {
      SnackBarWidget.showSnackBar("Error", "An error occurred.", "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
