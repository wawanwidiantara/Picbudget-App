import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/plan.dart';
import 'package:http/http.dart' as http;

class PicplanController extends GetxController {
  var plans = <Plan>[].obs;
  var selectedPlan = Plan().obs;
  var showAvg = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/plans/");

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
        final List<dynamic> planData = jsonResponse['data'];
        plans.value =
            planData.map((planJson) => Plan.fromJson(planJson)).toList();
        update();
      } else {
        print("Error fetching plans: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception while fetching plans: $e");
    }
  }

  Future<void> fetchPlanDetail(String planId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/plans/$planId/");

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
        print(jsonResponse['data']);
        selectedPlan.value = Plan.fromJson(jsonResponse['data']);
        update();
      } else {
        print("Error fetching plan detail: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception while fetching plan detail: $e");
    }
  }

  void toggleShowAvg() {
    showAvg.value = !showAvg.value;
  }

  Future<void> deletePlan(String id) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/plans/$id/");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        print("Plan deleted successfully");
        plans.removeWhere((plan) => plan.id == id);
        update();
      } else {}
    } catch (e) {}
  }
}
