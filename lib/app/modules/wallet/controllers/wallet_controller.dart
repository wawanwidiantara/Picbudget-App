import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/wallet.dart';

class WalletController extends GetxController {
  // Observable list of wallets
  var wallets = <Wallet>[].obs;
  var totalBalance = 0.0.obs;

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
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> createWallet(String name, String type, double balance) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    final userId = storage.read('user')['id']; // Retrieve user ID
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/");

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'type': type,
          'balance': balance.toString(),
          'user': userId,
        }),
      );

      if (response.statusCode == 201) {
        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        final Wallet newWallet = Wallet.fromJson(jsonResponse);
        wallets.add(newWallet); // Add new wallet to the list

        // Log success
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> updateWallet(
      String id, String name, String type, double balance) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$id/");

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'type': type,
          'balance': balance.toString(),
        }),
      );

      if (response.statusCode == 200) {
        // Parse the response
        final jsonResponse = jsonDecode(response.body);
        final Wallet updatedWallet = Wallet.fromJson(jsonResponse);

        // Update the wallet in the list
        wallets.value = wallets.map((wallet) {
          if (wallet.id == id) {
            return updatedWallet;
          }
          return wallet;
        }).toList();

        // Log success
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> deleteWallet(String id) async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$id/");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        // Remove the wallet from the list
        wallets.removeWhere((wallet) => wallet.id == id);

        // Log success
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> fetchTotalBalance() async {
    final storage = GetStorage();
    final token = storage.read('access'); // Retrieve API token
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/total-balance/");

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
        totalBalance.value = jsonResponse['data']['total_balance'];
      } else {
        // Handle error response
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  String? getFirstWalletId() {
    if (wallets.isNotEmpty) {
      return wallets.first.id;
    }
    return null; // Return null if the list is empty
  }
}
