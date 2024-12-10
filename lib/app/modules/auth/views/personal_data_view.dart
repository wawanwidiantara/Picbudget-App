import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PersonalDataView extends GetView {
  const PersonalDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PersonalDataView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PersonalDataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
