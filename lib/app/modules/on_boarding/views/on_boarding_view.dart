import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnBoardingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnBoardingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
