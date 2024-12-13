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
import 'package:picbudget_app/app/data/models/transaction.dart';
import 'package:path/path.dart' as path;

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var items = <Item>[].obs;
  var selectedImage = ''.obs;
  File? receiptImage;
  var receipt = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions(); // Fetch transactions when the controller is initialized
  }

  Future<void> fetchTransactions({
    String? transactionDateFrom,
    String? transactionDateTo,
    String? walletId,
    String? type,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/");

    // Add query parameters if provided
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
        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> transactionData = jsonResponse['data'];

        // Map to Transaction model
        transactions.value = transactionData
            .map((transactionJson) => Transaction.fromJson(transactionJson))
            .toList();

        // Log success
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<Transaction?> getTransactionDetails(String id) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        return Transaction.fromJson(jsonResponse);
      } else {
        // Handle error response
        return null;
      }
    } catch (e) {
      // Handle exceptions
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
    final token = storage.read('access'); // Retrieve API token
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
        // Successfully created
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
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
    final token = storage.read('access'); // Retrieve API token
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
        // Successfully updated
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> deleteTransaction(String id) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
        // Successfully deleted
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> fetchTransactionItems(String transactionId) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> itemData = jsonResponse['data'];

        // Map to Item model
        items.value =
            itemData.map((itemJson) => Item.fromJson(itemJson)).toList();
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<Item?> getTransactionItemDetail(String itemId) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
        return Item.fromJson(jsonResponse['data']);
      } else {
        return null; // Handle error response
      }
    } catch (e) {
      return null; // Handle exceptions
    }
  }

  Future<void> createTransactionItem({
    required String transactionId,
    required String itemName,
    required double itemPrice,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
        // Successfully created
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> updateTransactionItem({
    required String itemId,
    required String itemName,
    required double itemPrice,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    var url = Uri.parse("${UrlApi.baseAPI}/api/transaction-items/$itemId/");

    try {
      final response = await http.put(
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
        // Successfully updated
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> deleteTransactionItem(String itemId) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
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
  Future<void> getReceiptImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: imageSource);

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
      quality: 50, // Adjust the quality as needed
    );

    return result;
  }
}
