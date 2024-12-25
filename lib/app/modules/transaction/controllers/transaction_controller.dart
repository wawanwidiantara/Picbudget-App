import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/item.dart';
import 'package:picbudget_app/app/data/models/label.dart';
import 'package:picbudget_app/app/data/models/transaction.dart';
import 'package:path/path.dart' as path;

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var items = <Item>[].obs;
  var labels = <Label>[].obs;
  var selectedImage = ''.obs;
  File? receiptImage;
  var receipt = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions({
    String? transactionDateFrom,
    String? transactionDateTo,
    String? walletId,
    String? type,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/");

    final queryParameters = {
      if (transactionDateFrom != null)
        'transaction_date_from': transactionDateFrom,
      if (transactionDateTo != null) 'transaction_date_to': transactionDateTo,
      if (walletId != null) 'wallet': walletId,
      if (type != null) 'type': type,
    };

    url = Uri.parse(
        "${url.toString()}?${queryParameters.entries.map((e) => "${e.key}=${Uri.encodeComponent(e.value)}").join("&")}");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> transactionData = jsonResponse['data'];

        transactions.value = transactionData
            .map((transactionJson) => Transaction.fromJson(transactionJson))
            .toList();
      } else {}
    } catch (e) {}
  }

  Future<Transaction?> getTransactionDetails(String id) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/$id/");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['data'] != null) {
          return Transaction.fromJson(jsonResponse['data']);
        } else {
          return Transaction.fromJson(jsonResponse);
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> createTransaction({
    required String type,
    required double amount,
    required DateTime transactionDate,
    String? location,
    required XFile receipt,
    required List<String> labels,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/");

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['type'] = type
      ..fields['amount'] = amount.toString()
      ..fields['transaction_date'] = transactionDate.toIso8601String()
      ..fields['labels'] = labels.join(',')
      ..files.add(await http.MultipartFile.fromPath('receipt', receipt.path));

    if (location != null) {
      request.fields['location'] = location;
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
      } else {}
    } catch (e) {}
  }

  Future<void> updateTransaction({
    required String id,
    required String type,
    required double amount,
    required DateTime transactionDate,
    String? location,
    required XFile receipt,
    required List<String> labels,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/$id/");

    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['type'] = type
      ..fields['amount'] = amount.toString()
      ..fields['transaction_date'] = transactionDate.toIso8601String()
      ..fields['labels'] = labels.join(',')
      ..files.add(await http.MultipartFile.fromPath('receipt', receipt.path));

    if (location != null) {
      request.fields['location'] = location;
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }

  Future<void> deleteTransaction(String id) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/$id/");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        transactions.removeWhere((transaction) => transaction.id == id);
      } else {}
    } catch (e) {}
  }

  Future<List<Item>> fetchTransactionItems(String transactionId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse(
        "${UrlApi.baseAPI}/api/transaction-items/?transaction=$transactionId");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          final List<dynamic> itemData = jsonResponse['data'];
          final List<Item> itemList =
              itemData.map((itemJson) => Item.fromJson(itemJson)).toList();
          return itemList;
        } else {
          SnackBarWidget.showSnackBar(
            'Error',
            'Failed to fetch transaction items',
            'err',
          );
          return [];
        }
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          'Failed to fetch transaction items',
          'err',
        );
        return [];
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Failed to fetch transaction items',
        'err',
      );
      return [];
    }
  }

  Future<Item?> getTransactionItemDetail(String itemId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transaction-items/$itemId/");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          return Item.fromJson(jsonResponse['data']);
        } else {
          return Item.fromJson(jsonResponse);
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> createTransactionItem({
    required String transactionId,
    required String itemName,
    required double itemPrice,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transaction-items/");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'transaction': transactionId,
          'item_name': itemName,
          'item_price': itemPrice,
        }),
      );

      if (response.statusCode == 201) {
      } else {}
    } catch (e) {}
  }

  Future<void> updateTransactionItem({
    required String itemId,
    required String itemName,
    required double itemPrice,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transaction-items/$itemId/");

    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'item_name': itemName,
          'item_price': itemPrice,
        }),
      );

      if (response.statusCode == 200) {
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          response.body,
          'err',
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Failed to update item $e',
        'err',
      );
    }
  }

  Future<void> deleteTransactionItem(String itemId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transaction-items/$itemId/");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        items.removeWhere((item) => item.id == itemId);
        update();
        SnackBarWidget.showSnackBar(
          'Success',
          'Item deleted successfully!',
          'success',
        );
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          'Item deletion failed. Please try again.',
          'err',
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Item deletion failed. Please try again.',
        'err',
      );
    }
  }

  Future<void> fetchLabels() async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/labels/");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> labelData = jsonResponse['data'];

        labels.value =
            labelData.map((labelJson) => Label.fromJson(labelJson)).toList();
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          'Failed to fetch labels',
          'err',
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Failed to fetch labels: $e',
        'err',
      );
    }
  }

  Future<Label?> getLabelDetail(String id) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/labels/$id/");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['data'] != null) {
          return Label.fromJson(jsonResponse['data']);
        } else {
          SnackBarWidget.showSnackBar(
            'Error',
            'Label data not found.',
            'err',
          );
          return null;
        }
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          'Failed to fetch label details. Status: ${response.statusCode}',
          'err',
        );
        return null;
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Failed to fetch label details: $e',
        'err',
      );
      return null;
    }
  }

  Future<void> updateTransactionLabel({
    required String transactionId,
    required List<String> labels,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/$transactionId/");

    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'labels': labels}),
      );

      if (response.statusCode == 200) {
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          response.body,
          'err',
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Error',
        'Failed to update item $e',
        'err',
      );
    }
  }

  Future<void> getReceiptImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      File receiptImage = File(pickedFile.path);
      selectedImage.value = pickedFile.path.toString();

      XFile? compressedImage = await compressImage(receiptImage);

      if (compressedImage != null) {
        this.receiptImage = File(compressedImage.path);
        SnackBarWidget.showSnackBar(
          'Success',
          'Image selected and compressed successfully!',
          'success',
        );
      } else {
        SnackBarWidget.showSnackBar(
          'Error',
          'Image compression failed.',
          'err',
        );
      }
    } else {
      SnackBarWidget.showSnackBar(
        'Error',
        'No image selected.',
        'err',
      );
    }
  }

  Future<XFile?> compressImage(File image) async {
    final compressedImagePath =
        '${path.dirname(image.path)}/compressed_${path.basename(image.path)}';

    var result = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      compressedImagePath,
      quality: 50,
    );

    return result;
  }
}
