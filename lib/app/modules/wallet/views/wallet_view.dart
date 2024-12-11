import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WalletView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
