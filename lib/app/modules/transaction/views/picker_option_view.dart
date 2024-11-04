import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_controller.dart';

class PickerOptionView extends GetView {
  const PickerOptionView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.mainBackground,
          selectedItemColor: AppColors.primaryBlack,
          selectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: (int index) {
            Get.back();
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: AppColors.primaryBlack),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.wallet_rounded,
                          size: 20,
                          color: AppColors.mainBackground,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PicWallets',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.mainBackground,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: AppColors.primaryColor),
                    child: IconButton(
                      onPressed: () {
                        // Get.toNamed(Routes.NAVBAR);
                      },
                      icon: const Icon(
                        Icons.notifications,
                        size: 20,
                      ),
                      color: AppColors.primaryBlack,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),
              const Text('Jangan biarin nilai PicBudget turun',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal)),
              const SizedBox(height: 8),
              const Text('Total Uangku',
                  style: TextStyle(
                      fontSize: 28,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Obx(() => Text(
                    'Rp. ${controller.homC.totalBalance.value}',
                    style: const TextStyle(
                        fontSize: 32,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.normal),
                  )),
              const SizedBox(height: 24),
              const Text('Tampilan rekap pengeluaran',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlack,
                      fontWeight: FontWeight.normal)),
              const SizedBox(height: 16),
              SizedBox(
                  height: 34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.homC.summaryBy.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () {
                            controller.homC.current.value = index;
                          },
                          child: Obx(() => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        controller.homC.current.value == index
                                            ? AppColors.primaryColor
                                            : AppColors.primaryBlack),
                                child: Text(
                                  controller.homC.summaryBy[index],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          controller.homC.current.value == index
                                              ? AppColors.primaryBlack
                                              : AppColors.mainBackground,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      );
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  Hero(
                    tag: 'pengeluaran',
                    child: Container(
                      height: 160,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16)),
                          color: AppColors.primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/outcome.svg',
                              ),
                              const Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 32,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pengeluaran",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.primaryBlack),
                              ),
                              Text("- Rp. 1.000.000",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColors.primaryBlack)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'pendapatan',
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Container(
                          height: 160,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16)),
                              color: AppColors.primaryBlack),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Icon',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.mainBackground,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Pendapatan",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.mainBackground,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "+ Rp. 1.000.000",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.mainBackground,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'transaction',
                    child: Material(
                      type: MaterialType.transparency,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: 336,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16)),
                                color: AppColors.purple),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Get.width - 64,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // SizedBox(),
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: AppColors.mainBackground,
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width - 64,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Get.to(() => ManualTransactionView());
                                        },
                                        child: Container(
                                          height: 112,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: AppColors.mainBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.edit,
                                                      size: 24,
                                                      color: AppColors.purple,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color: AppColors
                                                          .primaryBlack,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Manual',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .primaryBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Input manual',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .primaryBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      InkWell(
                                        onTap: () {
                                          Get.bottomSheet(
                                              Container(
                                                height: Get.height * 0.25,
                                                // color: AppColors.mainBackground,
                                                decoration: const BoxDecoration(
                                                    color: AppColors
                                                        .mainBackground,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(16),
                                                            topRight:
                                                                Radius.circular(
                                                                    16))),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    const Text('Opsi',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: AppColors
                                                                .primaryBlack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    ListTile(
                                                      onTap: () {
                                                        Get.back();
                                                        controller
                                                            .getReceiptImage(
                                                                ImageSource
                                                                    .camera);
                                                      },
                                                      title:
                                                          const Text('Kamera'),
                                                      titleTextStyle:
                                                          const TextStyle(
                                                              fontSize: 18,
                                                              color: AppColors
                                                                  .primaryBlack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    ListTile(
                                                      onTap: () {
                                                        Get.back();
                                                        controller
                                                            .getReceiptImage(
                                                                ImageSource
                                                                    .gallery);
                                                      },
                                                      title:
                                                          const Text('Galeri'),
                                                      titleTextStyle:
                                                          const TextStyle(
                                                              fontSize: 18,
                                                              color: AppColors
                                                                  .primaryBlack,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              isScrollControlled: false);
                                        },
                                        child: Container(
                                          height: 112,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: AppColors.mainBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.document_scanner,
                                                      size: 24,
                                                      color: AppColors.purple,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color: AppColors
                                                          .primaryBlack,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'PicOCR',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .primaryBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Scan struknya',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .primaryBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Catat\nTransaksi",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
