import 'package:get/get.dart';

import '../models/transaction_model.dart';

class TransactionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Transaction.fromJson(map);
      if (map is List)
        return map.map((item) => Transaction.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Transaction?> getTransaction(int id) async {
    final response = await get('transaction/$id');
    return response.body;
  }

  Future<Response<Transaction>> postTransaction(
          Transaction transaction) async =>
      await post('transaction', transaction);
  Future<Response> deleteTransaction(int id) async =>
      await delete('transaction/$id');
}
