import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/transaction/views/receipt_view.dart';
import 'package:picbudget_app/app/modules/transaction/views/transaction_detail_view.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

import '../controllers/pic_scan_controller.dart';

class PicScanView extends GetView<PicScanController> {
  const PicScanView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PicScanController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('PicScan'),
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(
              () => controller.nerResult.isEmpty
                  ? LoadingScan()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _receiptImage(controller),
                        const SizedBox(height: 32),
                        _title(controller),
                        const SizedBox(
                          height: 8,
                        ),
                        _amount(controller),
                        const SizedBox(
                          height: 16,
                        ),
                        _date(controller),
                        const SizedBox(
                          height: 16,
                        ),
                        _place(),
                        const SizedBox(
                          height: 16,
                        ),
                        _location(controller),
                      ],
                    ),
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(() => controller.nerResult.isEmpty
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                toggleColor: AppColors.white,
                backgroundColor: AppColors.secondary,
                action: (ctrl) async {
                  ctrl.loading();
                  await controller.confirmTransaction(
                      transactionId: controller.nerResult['id'].toString());
                  if (controller.transactionCreated.value) {
                    ctrl.success();
                    await Future.delayed(const Duration(milliseconds: 1500));
                    Get.offAllNamed(Routes.NAVBAR);
                  } else {
                    ctrl.reset();
                  }
                },
                child: Text(
                  'Geser untuk menyimpan',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Row _title(PicScanController controller) {
    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const TransactionDetailView(),
                                  arguments: controller.nerResult["id"]);
                            },
                            child: Text(
                              'Detail',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
  }

  Center _receiptImage(PicScanController controller) {
    return Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const ReceiptView(),
                                arguments: controller.nerResult['receipt']);
                          },
                          child: Hero(
                            tag: 'receipt',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: SizedBox(
                                  width: Get.width * 0.6,
                                  height: Get.height * 0.4,
                                  child: Image.network(
                                      controller.nerResult['receipt']
                                          .toString(),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      );
  }

  Text _amount(PicScanController controller) {
    return Text(
                        '- Rp. ${controller.nerResult['amount']}',
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      );
  }

  Row _location(PicScanController controller) {
    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          SizedBox(
                            width: Get.width * 0.6,
                            child: Text(
                              controller.nerResult['location'] == null
                                  ? '-'
                                  : controller.nerResult['location']
                                      .toString(),
                              overflow: TextOverflow.clip,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      );
  }

  Row _place() {
    return Row(
                        children: [
                          Text(
                            'Place',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '-',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
  }

  Row _date(PicScanController controller) {
    return Row(
                        children: [
                          Text(
                            'Date',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd – kk:mm').format(
                              DateTime.parse(controller
                                  .nerResult['transaction_date']
                                  .toString()),
                            ),
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
  }
}

class LoadingScan extends StatelessWidget {
  const LoadingScan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32,
          ),
          Lottie.asset(
            'assets/lotties/scan_loading_v3.json',
          ),
          Text(
            'The Receipt is Being Processed',
            textAlign: TextAlign.center,
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Processing the receipt with PicScan. Please wait a moment...',
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.normal,
            ),
          ),
        ]);
  }
}
