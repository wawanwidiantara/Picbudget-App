import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/core/constants/url.dart';
import 'package:picbudget_app/app/data/models/wallet.dart';

class WalletController extends GetxController {
  var wallets = <Wallet>[].obs;
  var totalBalance = 0.0.obs;
  var walletCreated = false.obs;
  var selectedWallet = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallets();
    fetchTotalBalance();
  }

  Future<void> fetchWallets() async {
    final storage = GetStorage();
    final token = storage.read('access');
    final userId = storage.read('user')['id'];
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/");

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
        final List<dynamic> walletData = jsonResponse['data'];
        wallets.value = walletData
            .where((wallet) => wallet['user'] == userId)
            .map((walletJson) => Wallet.fromJson(walletJson))
            .toList();
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<void> fetchWalletDetail(String walletId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$walletId/");

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
        selectedWallet.value = jsonResponse['data'];
        update();
      } else {
        print("Error fetching wallet detail: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception while fetching wallet detail: $e");
    }
  }

  Future<void> createWallet(String name, String type, double balance) async {
    walletCreated(false);

    final storage = GetStorage();
    final token = storage.read('access');
    final userId = storage.read('user')['id'];
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
        final jsonResponse = jsonDecode(response.body);
        final Wallet newWallet = Wallet.fromJson(jsonResponse);
        wallets.add(newWallet);
        walletCreated(true);
      } else {
        walletCreated(false);
      }
    } catch (e) {
      walletCreated(false);
    }
  }

  Future<void> updateWallet(
      String id, String name, String type, double balance) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$id/");

    try {
      final response = await http.patch(
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
        final jsonResponse = jsonDecode(response.body);
        final Wallet updatedWallet = Wallet.fromJson(jsonResponse);

        wallets.value = wallets.map((wallet) {
          if (wallet.id == id) {
            return updatedWallet;
          }
          return wallet;
        }).toList();
      } else {}
    } catch (e) {}
  }

  Future<void> deleteWallet(String id) async {
    final storage = GetStorage();
    final token = storage.read('access');
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
        wallets.removeWhere((wallet) => wallet.id == id);
        update();
      } else {}
    } catch (e) {}
  }

  Future<void> fetchTotalBalance() async {
    final storage = GetStorage();
    final token = storage.read('access');
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
        final jsonResponse = jsonDecode(response.body);
        totalBalance.value = jsonResponse['data']['total_balance'];
        print(totalBalance.value);
      } else {
        print('error');
      }
    } catch (e) {
      print('error');
    }
  }

  String? getFirstWalletId() {
    if (wallets.isNotEmpty) {
      return wallets.first.id;
    }
    return null;
  }

  Future<String> getWalletType(String walletId) async {
    final storage = GetStorage();
    final token = storage.read('access');
    var url = Uri.parse("${UrlApi.baseAPI}/api/wallets/$walletId/");

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
        return jsonResponse['data']['type'];
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
