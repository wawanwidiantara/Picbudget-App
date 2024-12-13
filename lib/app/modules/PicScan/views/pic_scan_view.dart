import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/transaction/views/receipt_view.dart';
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
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => controller.nerResult.isEmpty
                  ? Column(
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
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Center(
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
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Belanja',
                                style: AppTypography.bodyLarge.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print(controller.nerResult);
                                  // controller.createTransaction();
                                  // Get.to(() => const PicOcrDetailView());
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
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '- Rp. ${controller.nerResult['amount']}',
                            style: AppTypography.headlineMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                'Tanggal',
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          Row(
                            children: [
                              Text(
                                'Tempat',
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
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alamat',
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
                          ),
                          Center(
                            child: ActionSlider.standard(
                              sliderBehavior: SliderBehavior.stretch,
                              toggleColor: AppColors.white,
                              backgroundColor: AppColors.secondary,
                              action: (ctrl) async {
                                ctrl.loading(); //starts loading animation
                                await controller.confirmTransaction(
                                    transactionId:
                                        controller.nerResult['id'].toString());
                                if (controller.transactionCreated.value) {
                                  ctrl.success();
                                  await Future.delayed(
                                      const Duration(milliseconds: 1500));
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
                              // ... //many more parameters
                            ),
                          )
                          // : Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Center(
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             Get.to(() => const ReceiptView(),
                          //                 arguments: controller
                          //                     .nerResult['receipt_image_url']);
                          //           },
                          //           child: Hero(
                          //             tag: 'receipt',
                          //             child: ClipRRect(
                          //               borderRadius: const BorderRadius.only(
                          //                 topLeft: Radius.circular(16),
                          //                 topRight: Radius.circular(16),
                          //                 bottomLeft: Radius.circular(16),
                          //               ),
                          //               child: SizedBox(
                          //                   width: Get.width * 0.6,
                          //                   height: Get.height * 0.4,
                          //                   child: Image.network(
                          //                       controller
                          //                           .nerResult['receipt_image_url']
                          //                           .toString(),
                          //                       fit: BoxFit.cover)),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 32,
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           const Text(
                          //             'Total Belanja',
                          //             style: TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               // controller.createTransaction();
                          //               Get.to(() => const PicOcrDetailView());
                          //             },
                          //             child: const Text(
                          //               'Detail',
                          //               style: TextStyle(
                          //                 color: AppColors.primaryColor,
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 8,
                          //       ),
                          //       Text(
                          //         '- Rp. ${controller.nerResult['total']}',
                          //         style: const TextStyle(
                          //           color: AppColors.primaryBlack,
                          //           fontSize: 32,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 16,
                          //       ),
                          //       Row(
                          //         children: [
                          //           const Text(
                          //             'Tanggal',
                          //             style: TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 16,
                          //           ),
                          //           Text(
                          //             controller.nerResult['date'].toString(),
                          //             style: const TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 16,
                          //       ),
                          //       const Row(
                          //         children: [
                          //           Text(
                          //             'Tempat',
                          //             style: TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 20,
                          //           ),
                          //           Text(
                          //             '-',
                          //             style: TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 16,
                          //       ),
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const Text(
                          //             'Alamat',
                          //             style: TextStyle(
                          //               color: AppColors.primaryBlack,
                          //               fontSize: 12,
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 22,
                          //           ),
                          //           SizedBox(
                          //             width: Get.width * 0.6,
                          //             child: Text(
                          //               controller.nerResult['address'] == null
                          //                   ? '-'
                          //                   : controller.nerResult['address']
                          //                       .toString(),
                          //               overflow: TextOverflow.clip,
                          //               style: const TextStyle(
                          //                 color: AppColors.primaryBlack,
                          //                 fontSize: 12,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 32,
                          //       ),
                          //       Center(
                          //         child: ActionSlider.standard(
                          //           sliderBehavior: SliderBehavior.stretch,
                          //           toggleColor: AppColors.mainBackground,
                          //           backgroundColor: AppColors.primaryBlack,
                          //           action: (ctrl) async {
                          //             ctrl.loading(); //starts loading animation
                          //             await controller.createTransaction();
                          //             if (controller.transactionCreated.value) {
                          //               ctrl.success();
                          //               await Future.delayed(
                          //                   const Duration(milliseconds: 1500));
                          //               Get.offAllNamed(Routes.NAVBAR);
                          //             } else {
                          //               ctrl.reset();
                          //             }
                          //             // ctrl.success();
                          //             // await Future.delayed(
                          //             //     const Duration(milliseconds: 1500));
                          //             // Get.offAllNamed(Routes.NAVBAR);
                          //           },
                          //           child: const Text('Geser untuk menyimpan',
                          //               style: TextStyle(
                          //                 color: AppColors.mainBackground,
                          //                 fontSize: 14,
                          //                 fontWeight: FontWeight.bold,
                          //               )),
                          //           // ... //many more parameters
                          //         ),
                          //       )
                          //     ],
                          //   ),
                        ]),
            ),
          ),
        ),
      ),
    );
  }
}
