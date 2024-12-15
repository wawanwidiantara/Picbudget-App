import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
