import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/constans/url.dart';
import 'package:picbudget_app/app/modules/login/controllers/login_controller.dart';

class HomeController extends GetxController {
  final loginController = Get.put(LoginController());
  var current = 0.obs;
  List<String> summaryBy = ['Harian', 'Mingguan', 'Bulanan'];
  var idTab = Get.arguments;
  var totalBalance = 0.obs;
  var totalIncome = 0.obs;
  var totalExpense = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getTotalBalance();
    getTotalTransaction();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getTotalBalance() async {
    try {
      var url = Uri.parse("${UrlApi.baseAPI}/total-amount/");
      var token = 'Bearer ${loginController.getStorage.read("access_token")}';
      final response = await http.get(
        url,
        headers: <String, String>{'Authorization': token},
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        totalBalance.value = res['total_amount'].round();
        update();
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  getTotalTransaction() async {
    try {
      var url = Uri.parse("${UrlApi.baseAPI}/total-transactions/");
      var token = 'Bearer ${loginController.getStorage.read("access_token")}';
      final response = await http.get(
        url,
        headers: <String, String>{'Authorization': token},
      );
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        totalExpense.value = res['total_transactions'].round();
        update();
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
