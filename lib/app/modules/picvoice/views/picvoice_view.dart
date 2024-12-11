import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/picvoice_controller.dart';

class PicvoiceView extends GetView<PicvoiceController> {
  const PicvoiceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicvoiceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PicvoiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
