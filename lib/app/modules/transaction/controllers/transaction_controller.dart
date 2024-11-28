import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picbudget_app/app/constans/url.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:picbudget_app/app/modules/home/controllers/home_controller.dart';
import 'package:picbudget_app/app/modules/login/controllers/login_controller.dart';

class TransactionController extends GetxController {
  final loginController = Get.put(LoginController());
  final homC = Get.find<HomeController>();
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

  Future<void> getReceiptImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      File receiptImage = File(pickedFile.path);
      selectedImage.value = pickedFile.path.toString();
      nerResult.clear(); // Uncomment if you want to navigate to PicOcrView

      sendImage(
          receiptImage); // Wait for the image to be sent before proceeding
    } else {
      print('No image selected.');
    }
  }

  Future<void> sendImage(File image) async {
    var url = Uri.parse("${UrlApi.baseAPI}/extract/");
    var token = 'Bearer ${loginController.getStorage.read("access_token")}';

    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = token;

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      image.path,
      filename: path.basename(image.path),
    ));

    try {
      print("Posting image to the backend");
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        var res = json.decode(responseData.body);
        nerResult.value = res;
        update();
      } else {
        print('Error response: ${responseData.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
