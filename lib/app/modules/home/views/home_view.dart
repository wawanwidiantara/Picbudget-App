import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';
import 'package:picbudget_app/app/modules/transaction/views/picker_option_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            backgroundColor: AppColors.mainBackground,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          'Rp. ${controller.totalBalance.value.toString()}',
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
                          itemCount: controller.summaryBy.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  controller.current.value = index;
                                },
                                child: Obx(() => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color:
                                              controller.current.value == index
                                                  ? AppColors.primaryColor
                                                  : AppColors.primaryBlack),
                                      child: Text(
                                        controller.summaryBy[index],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: controller.current.value ==
                                                    index
                                                ? AppColors.primaryBlack
                                                : AppColors.mainBackground,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 16),
                    Table(
                      children: [
                        TableRow(children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Hero(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/outcome.svg',
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(() => const ExpenseView(),
                                              //     arguments: controller
                                              //         .totalExpense.value);
                                            },
                                            child: const Icon(
                                              Icons.arrow_circle_right_outlined,
                                              size: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Pengeluaran",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color:
                                                        AppColors.primaryBlack),
                                          ),
                                          Obx(() => Text(
                                              "- Rp. ${controller.totalExpense.value}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .primaryBlack))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Table(children: [
                            TableRow(children: [
                              Hero(
                                tag: 'pendapatan',
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, right: 8),
                                    child: Container(
                                      height: 160,
                                      padding: const EdgeInsets.all(16),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16)),
                                          color: AppColors.primaryBlack),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/income.svg',
                                              ),
                                              const SizedBox(),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Pendapatan",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              Text(
                                                "+ Rp. 1.000.000",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                  child: Hero(
                                    tag: 'transaction',
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        height: 160,
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                                bottomLeft:
                                                    Radius.circular(16)),
                                            color: AppColors.purple),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                IconButton(
                                                    onPressed: () {
                                                      Get.to(
                                                          transition: Transition
                                                              .noTransition,
                                                          popGesture: false,
                                                          arguments: 1,
                                                          () =>
                                                              const PickerOptionView());
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: AppColors
                                                          .mainBackground,
                                                    ))
                                              ],
                                            ),
                                            const Text(
                                              "Catat\nTransaksi",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      AppColors.mainBackground,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            //
                          ]),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
