import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable data for Spending Overview
  var spendingData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSpendingData();
  }

  Future<void> fetchSpendingData() async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 2));

    // Example data fetched from API
    spendingData.value = [
      {'category': 'Food & Drinks', 'amount': 8221, 'color': '#221f20'},
      {'category': 'Life & Entertainment', 'amount': 4300, 'color': '#ebd279'},
      {'category': 'Others', 'amount': 3000, 'color': '#bebebe'},
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
