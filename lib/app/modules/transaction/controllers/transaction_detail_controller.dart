import 'dart:ffi';

import 'package:get/get.dart';
import 'package:picbudget_app/app/data/models/item.dart';
import 'package:picbudget_app/app/data/models/transaction.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_controller.dart';

class TransactionDetailController extends GetxController {
  final transactionId = Get.arguments;
  final transactionController = Get.put(TransactionController());

  var transactionDetail = Rxn<Transaction>();
  var transactionItems = <Item>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactionDetail();
    fetchTransactionItems();
  }

  Future<void> fetchTransactionDetail() async {
    if (transactionId != null) {
      isLoading.value = true;
      try {
        final detail =
            await transactionController.getTransactionDetails(transactionId);
        if (detail != null) {
          transactionDetail.value = detail;
        } else {
          Get.snackbar('Error', 'Failed to fetch transaction details');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Transaction ID is missing');
    }
  }

  Future<void> fetchTransactionItems() async {
    if (transactionId != null) {
      isLoading.value = true;
      try {
        final items =
            await transactionController.fetchTransactionItems(transactionId);
        if (items.isNotEmpty) {
          transactionItems.assignAll(items);
        } else {
          // Get.snackbar('Error', 'Failed to fetch transaction items');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Transaction ID is missing');
    }
  }

  Future<void> deleteTransactionItem(String itemId) async {
    if (itemId.isNotEmpty) {
      isLoading.value = true;
      try {
        await transactionController.deleteTransactionItem(itemId);

        transactionItems.removeWhere((item) => item.id == itemId);
        update();
      } catch (e) {
        Get.snackbar('Error', 'Failed to delete item: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Item ID is missing');
    }
  }

  Future<void> updateTransactionItem(
      String itemId, String newName, double newPrice) async {
    if (itemId.isNotEmpty && newName.isNotEmpty) {
      isLoading.value = true;
      try {
        // Assume transactionController has a method to update item details
        await transactionController.updateTransactionItem(
          itemId: itemId,
          itemName: newName,
          itemPrice: newPrice,
        );
        // Update the item locally
        final index = transactionItems.indexWhere((item) => item.id == itemId);
        if (index != -1) {
          transactionItems[index].itemName = newName;
          transactionItems[index].itemPrice = newPrice;
          transactionItems.refresh(); // Trigger UI update
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to update item: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Invalid item ID, name, or price');
    }
  }
}
