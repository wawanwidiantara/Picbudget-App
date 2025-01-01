import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/data/models/label.dart';
import 'package:picbudget_app/app/data/models/wallet.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';
import 'package:picbudget_app/app/modules/picplan/controllers/picplan_controller.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:http/http.dart' as http;

class CreatePicplanController extends GetxController {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController periodController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final getStorage = GetStorage();

  final picplanController = Get.put(PicplanController());

  final walletController = Get.put(WalletController());
  var availableWallets = <Wallet>[].obs; // All available Wallets
  var selectedWallets = <Wallet>[].obs;

  final transactionController = Get.put(TransactionController());
  var availableLabels = <Label>[].obs; // All available labels
  var selectedLabels = <Label>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchAvailableLabels();
    fetchAvailableWallets();
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

  Future<void> fetchAvailableLabels() async {
    isLoading.value = true;
    try {
      await transactionController.fetchLabels();
      availableLabels.assignAll(transactionController.labels);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAvailableWallets() async {
    isLoading.value = true;
    try {
      await walletController.fetchWallets();
      availableWallets.assignAll(walletController.wallets);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleLabelSelection(Label label) async {
    if (selectedLabels.contains(label)) {
      selectedLabels.remove(label);
    } else {
      selectedLabels.add(label);
    }
  }

  Future<void> toggleWalletSelection(Wallet wallet) async {
    if (selectedWallets.contains(wallet)) {
      selectedWallets.remove(wallet);
    } else {
      selectedWallets.add(wallet);
    }
  }

  Future<void> createPlan() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading.value = true;
    try {
      final token = getStorage.read('access');
      var url = Uri.parse("${UrlApi.baseAPI}/api/plans/");

      // Build the body dynamically
      Map<String, dynamic> body = {
        "name": nameController.text,
        "amount": int.tryParse(amountController.text),
        "period": periodController.text,
        "notify_overspent": true,
      };

      if (selectedLabels.isNotEmpty) {
        body["labels"] = selectedLabels.map((label) => label.id).toList();
      }

      if (selectedWallets.isNotEmpty) {
        body["wallets"] = selectedWallets.map((wallet) => wallet.id).toList();
      }

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        picplanController.fetchPlans();
        Get.back();
        SnackBarWidget.showSnackBar(
            "Success", "Plan created successfully.", "success");
      } else if (response.statusCode == 401) {
        // Handle token expiration
        bool refreshed = await _authService.checkAuthState();
        if (refreshed) {
          await createPlan(); // Retry if token refreshed
        } else {
          Get.offAll(() => LoginView());
        }
      } else {
        // Handle other errors
        SnackBarWidget.showSnackBar(
          "Error",
          "Failed to create plan. Status: ${response.statusCode}",
          "err",
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        "Error",
        "An error occurred while creating the plan.",
        "err",
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
