import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/picreport_controller.dart';

class PicreportView extends GetView<PicreportController> {
  const PicreportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicreportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PicreportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
