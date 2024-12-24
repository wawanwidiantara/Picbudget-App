import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CreatePicplanView extends GetView {
  const CreatePicplanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreatePicplanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePicplanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
