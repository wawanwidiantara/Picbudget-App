import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/wallet.dart';

class WalletController extends GetxController {
  // Observable list of wallets
  var wallets = <Wallet>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallets(); // Fetch wallets when the controller is initialized
  }

  Future<void> fetchWallets() async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    final userId = storage.read('user')['id']; // Retrieve user ID
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/");
    // Replace with your base URL

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
        final List<dynamic> walletData = jsonResponse['data'];

        // Filter wallets by user ID and map to Wallet model
        wallets.value = walletData
            .where((wallet) => wallet['user'] == userId)
            .map((walletJson) => Wallet.fromJson(walletJson))
            .toList();

        // Log success
        print('Wallets fetched successfully');
      } else {
        // Handle error response
        print(
            'Error fetching wallets: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception occurred: $e');
    }
  }

  String? getFirstWalletId() {
    if (wallets.isNotEmpty) {
      return wallets.first.id;
    }
    return null; // Return null if the list is empty
  }
}
