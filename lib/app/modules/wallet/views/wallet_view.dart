import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/wallet/views/create_wallet_view.dart';

import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Obx(
                        () => Text(
                          'Rp. ${controller.totalBalance.value}',
                          style: AppTypography.headlineMedium.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Obx(
                        () => controller.wallets.isEmpty
                            ? Text("Empty")
                            : ListWallet(controller: controller),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListWallet extends StatelessWidget {
  const ListWallet({
    super.key,
    required this.controller,
  });

  final WalletController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.wallets.length,
      itemBuilder: (context, index) {
        final wallet = controller.wallets[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.neutral.neutralColor600,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallet.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    wallet.type,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rp. ${wallet.balance}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 72,
                height: 54,
                decoration: BoxDecoration(
                  color: wallet.type == 'cash'
                      ? AppColors.secondary
                      : wallet.type == 'bank'
                          ? AppColors.primary
                          : AppColors.neutral
                              .neutralColor700, // Default to neutral for 'ewallet'
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset(wallet.type == 'cash'
                        ? "assets/images/picbudget logo primary.png"
                        : wallet.type == 'bank'
                            ? "assets/images/picbudget logo.png"
                            : "assets/images/picbudget logo white.png"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Wallet',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.account_balance_wallet,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => CreateWalletView());
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
