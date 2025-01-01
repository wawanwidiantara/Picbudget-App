import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/label.dart';
import 'package:picbudget_app/app/data/models/wallet.dart';
import 'package:picbudget_app/app/modules/picplan/controllers/picplan_controller.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:http/http.dart' as http;

class CreatePicplanController extends GetxController {
  final argument = Get.arguments;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController periodController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final getStorage = GetStorage();

  final picplanController = Get.put(PicplanController());

  final walletController = Get.put(WalletController());
  var availableWallets = <Wallet>[].obs;
  var selectedWallets = <Wallet>[].obs;

  var selectedPeriod = ''.obs;

  final transactionController = Get.put(TransactionController());
  var availableLabels = <Label>[].obs;
  var selectedLabels = <Label>[].obs;
  var isLoading = false.obs;
  var isEditMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      isEditMode.value = true;
      loadPlanData(argument);
    }
    fetchAvailableLabels();
    fetchAvailableWallets();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadPlanData(String planId) async {
    isLoading.value = true;
    try {
      await picplanController.fetchPlanDetail(planId);
      final plan = picplanController.selectedPlan.value;

      nameController.text = plan.name ?? '';
      amountController.text = plan.amount?.toInt().toString() ?? '';
      selectedPeriod.value = plan.period ?? '';

      if (plan.labels != null && plan.labels!.isNotEmpty) {
        selectedLabels.value = await fetchLabelsByIds(plan.labels!);
        selectedLabels.assignAll(
          availableLabels.where((label) => plan.labels!.contains(label.id)),
        );
      }

      if (plan.wallets != null && plan.wallets!.isNotEmpty) {
        selectedWallets.assignAll(
          availableWallets.where((wallet) => plan.wallets!.contains(wallet.id)),
        );
      }

      selectedLabels.refresh();
      selectedWallets.refresh();
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Label>> fetchLabelsByIds(List<String> labelIds) async {
    List<Label> fetchedLabels = [];
    final token = getStorage.read('access');
    try {
      for (String labelId in labelIds) {
        final url = Uri.parse("${UrlApi.baseAPI}/api/labels/$labelId/");
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final label = Label.fromJson(jsonResponse['data']);
          fetchedLabels.add(label);
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to fetch labels. Status: ${response.statusCode}",
            "err",
          );
        }
      }
    } catch (e) {
      SnackBarWidget.showSnackBar("Error", "An error occurred.", "$e");
    }
    return fetchedLabels;
  }

  Future<List<Wallet>> fetchWalletsByIds(List<String> walletIds) async {
    List<Wallet> fetchedWallets = [];
    final token = getStorage.read('access');
    try {
      for (String walletId in walletIds) {
        final url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$walletId/");
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          final wallet = Wallet.fromJson(jsonResponse['data']);
          fetchedWallets.add(wallet);
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to fetch wallets. Status: ${response.statusCode}",
            "err",
          );
        }
      }
    } catch (e) {
      SnackBarWidget.showSnackBar("Error", "An error occurred.", "$e");
    }
    return fetchedWallets;
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

  Future<void> createOrUpdatePlan() async {
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
          "amount": int.tryParse(amountController.text),
        if (selectedPeriod.isNotEmpty) "period": selectedPeriod.value,
        "notify_overspent": true,
      };

      if (selectedLabels.isNotEmpty) {
        body["labels"] = selectedLabels.map((label) => label.id).toList();
      }

      if (selectedWallets.isNotEmpty) {
        body["wallets"] = selectedWallets.map((wallet) => wallet.id).toList();
      }
      if (isEditMode.value) {
        url = Uri.parse("${UrlApi.baseAPI}/api/plans/$argument/");
        final response = await http.patch(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );
        if (response.statusCode == 200) {
          picplanController.fetchPlans();
          Get.back();
          SnackBarWidget.showSnackBar(
              "Success", "Plan updated successfully.", "success");
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to update plan. Status: ${response.statusCode}",
            "err",
          );
        }
      } else {
        url = Uri.parse("${UrlApi.baseAPI}/api/plans/");
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
        } else {
          SnackBarWidget.showSnackBar(
            "Error",
            "Failed to create plan. Status: ${response.statusCode}",
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
