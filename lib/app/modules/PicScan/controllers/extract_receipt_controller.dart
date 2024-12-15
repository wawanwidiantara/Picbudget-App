import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/transaction.dart';
import 'package:picbudget_app/app/modules/PicScan/views/pic_scan_view.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class ExtractReceiptController extends GetxController {
  var selectedImage = ''.obs;
  File? receiptImage;
  var receipt = ''.obs;
  var nerResult = {}.obs;

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

  Future<void> getReceiptImage(ImageSource imageSource, String walletId) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      Get.to(arguments: nerResult, () => const PicScanView());
      nerResult.clear();
      File receiptImage = File(pickedFile.path);
      selectedImage.value = pickedFile.path.toString();

      XFile? compressedImage = await compressImage(receiptImage);

      if (compressedImage != null) {
        await extractReceipt(compressedImage, walletId);
      } else {
        SnackBarWidget.showSnackBar(
          'Transaksi Gagal',
          'Error: Image compression failed.',
          'err',
        );
      }
    } else {
      SnackBarWidget.showSnackBar(
        'Transaksi Gagal',
        'Error: No image selected.',
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

  Future<void> extractReceipt(XFile image, String walletId) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve your API token
    final userId = storage.read('user')['id'];
    var url = Uri.parse("${UrlApi.baseAPI}/api/picscan-receipt/");

    // Create a multipart request
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] =
        'Bearer $token'; // Add Authorization Header

    // Add the image file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'receipt', // Match the field name expected by the API
      image.path,
      filename: path.basename(image.path),
    ));

    // Add additional form data (wallet_id and user_id)
    request.fields['wallet_id'] = walletId;
    request.fields['user_id'] = userId;

    try {
      // Send the request
      final response = await request.send();

      if (response.statusCode < 300) {
        // Parse the response
        final responseData = await http.Response.fromStream(response);
        final Map<String, dynamic> json = jsonDecode(responseData.body);

        // Assuming the API returns a response containing a 'data' field
        if (json['data'] != null) {
          var transaction = Transaction.fromJson(json['data']);
          receipt.value = transaction.receipt; // Save receipt URL
          nerResult.value = transaction.toJson();
          update();

          SnackBarWidget.showSnackBar(
            'Success',
            'Receipt extracted successfully!',
            'success',
          );
        } else {
          SnackBarWidget.showSnackBar(
            'Error',
            'Receipt extraction failed. Please try again.',
            'err',
          );
          Get.offAllNamed(Routes.NAVBAR);
        }
      } else {
        // Handle non-200 response codes
        final responseData = await http.Response.fromStream(response);
        SnackBarWidget.showSnackBar(
          'Error',
          'Error ${response.statusCode}: ${responseData.body}',
          'err',
        );
        Get.offAllNamed(Routes.NAVBAR);
      }
    } catch (e) {
      // Handle request errors
      SnackBarWidget.showSnackBar(
        'Error',
        'An error occurred: $e',
        'err',
      );
      Get.offAllNamed(Routes.NAVBAR);
    }
  }
}
