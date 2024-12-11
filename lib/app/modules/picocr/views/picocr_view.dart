import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/picocr_controller.dart';

class PicocrView extends GetView<PicocrController> {
  const PicocrView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicocrView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PicocrView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
