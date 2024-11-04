import 'dart:io';

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
      body: Center(
        child: Column(
          children: [
            Obx(
              () => controller.selectedImage.value == ""
                  ? Container()
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.file(
                        File(controller.selectedImage.value),
                        width: Get.width * 0.6,
                        height: Get.height * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
