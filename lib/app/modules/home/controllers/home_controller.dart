import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/constants/url.dart';

class HomeController extends GetxController {
  // Observable data for Spending Overview
  var spendingData = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();
  var totalSpending = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpendingData();
    getTotalSpending();
  }

  Future<void> fetchSpendingData() async {
    try {
      final token = storage.read('access'); // Get the access token
      var url = Uri.parse("${UrlApi.baseAPI}/api/transactions/summary/labels");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // Map API response to spendingData format
        spendingData.value = data.map<Map<String, dynamic>>((item) {
          return {
            'category': item['label'],
            'amount': (item['total_amount'] as num).toInt(),
            'color':
                _getCategoryColor(item['label']), // Assign colors dynamically
          };
        }).toList();
      } else {
        print("Failed to fetch spending data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching spending data: $e");
    }
  }

  Future<void> getTotalSpending() async {
    try {
      final token = storage.read('access'); // Get the access token
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
      } else {
        print("Failed to fetch total spending data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching total spending data: $e");
    }
  }

  // Assign colors dynamically based on the category
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
        return '#000000'; // Default to black
    }
  }
}
