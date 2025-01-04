import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/core/services/auth_services.dart';
import 'package:picbudget_app/app/modules/auth/views/login_view.dart';

class HomeController extends GetxController {
  var spendingData = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();
  var totalSpending = {}.obs;
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    fetchSpendingData();
    getTotalSpending();
  }

  Future<void> fetchSpendingData() async {
    try {
      final token = storage.read('access');
      var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/summary/labels/");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        spendingData.value = data.map<Map<String, dynamic>>((item) {
          return {
            'category': item['label'],
            'amount': (item['total_amount'] as num).toInt(),
            'color': _getCategoryColor(item['label']),
          };
        }).toList();
      } else if (response.statusCode == 401) {
        bool refreshed = await _authService.checkAuthState();
        if (refreshed) {
          await fetchSpendingData();
        } else {
          Get.offAll(() => LoginView());
        }
      } else {
        SnackBarWidget.showSnackBar(
          "Error",
          "Failed to fetch spending data. Status: ${response.statusCode}",
          "err",
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        "Error",
        "An error occurred while fetching spending data.",
        "err",
      );
    }
  }

  Future<void> getTotalSpending() async {
    try {
      final token = storage.read('access');
      var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/summary/");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        totalSpending.value = data;
      } else if (response.statusCode == 401) {
        bool refreshed = await _authService.checkAuthState();
        if (refreshed) {
          await getTotalSpending();
        } else {
          Get.offAll(() => LoginView());
        }
      } else {
        SnackBarWidget.showSnackBar(
          "Error",
          "Failed to fetch total spending data. Status: ${response.statusCode}",
          "err",
        );
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(
        "Error",
        "An error occurred while fetching total spending data.",
        "err",
      );
    }
  }

  String _getCategoryColor(String label) {
    switch (label) {
      case 'Beauty & Personal Care':
        return '#ff8a65';
      case 'Food & Baverage':
        return '#4caf50';
      case 'Home Living & Electronic':
        return '#42a5f5';
      case 'Live & Entertaiment':
        return '#e57373';
      case 'Other':
        return '#9e9e9e';
      case 'Unlabeled':
        return '#bdbdbd';
      default:
        return '#000000';
    }
  }
}
