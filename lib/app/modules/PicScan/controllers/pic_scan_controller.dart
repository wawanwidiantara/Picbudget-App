import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:http/http.dart' as http;

class PicScanController extends GetxController {
  var nerResult = Get.arguments;
  RxBool transactionCreated = false.obs;

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

  Future<void> confirmTransaction({
    required String transactionId,
  }) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url =
        Uri.parse("${UrlApi.baseAPI}/api/picscan-confirm/$transactionId/");

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        SnackBarWidget.showSnackBar(
          'Transaction Confirmed',
          'Transaction has been confirmed',
          'success',
        );
        transactionCreated(true);
      } else {
        SnackBarWidget.showSnackBar(
          'Transaction Failed',
          'Failed to confirm transaction',
          'success',
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        'Transaction Failed',
        'Failed to confirm transaction',
        'success',
      );
    }
  }
}
