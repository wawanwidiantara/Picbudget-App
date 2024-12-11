import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/picplan_controller.dart';

class PicplanView extends GetView<PicplanController> {
  const PicplanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicplanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PicplanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
