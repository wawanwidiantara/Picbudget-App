import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';

class ReceiptView extends GetView {
  const ReceiptView({super.key});
  @override
  Widget build(BuildContext context) {
    final receiptImage = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              Text('Receipt Image', style: TextStyle(color: AppColors.white)),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: receiptImage == null
            ? const Center(
                child: Text('No Image'),
              )
            : PhotoView(
                heroAttributes: PhotoViewHeroAttributes(tag: "receipt"),
                minScale: PhotoViewComputedScale.contained,
                imageProvider: NetworkImage(receiptImage.toString()),
              ));
  }
}
