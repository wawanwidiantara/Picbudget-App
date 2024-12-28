import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/transaction/views/transaction_history_view.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final wallet = Get.find<WalletController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Header(),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.brandColor.brandColor500,
                    AppColors.brandColor.brandColor300,
                  ]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 12),
                    Obx(() {
                      return Text(
                        'Rp. ${wallet.totalBalance.value}',
                        style: AppTypography.headlineLarge.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),
                    SizedBox(height: 24),
                    Obx(() {
                      if (controller.totalSpending.isEmpty) {
                        return Text("You haven't spent anything yet",
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.secondary,
                            ));
                      } else {
                        return SpendingWeek(controller: controller);
                      }
                    })
                  ],
                ),
              ),
              SizedBox(height: 24),
              _allFeature(),
              SizedBox(height: 32),
              SpendingHeader(),
              Obx(() {
                if (controller.spendingData.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child:
                        Center(child: Text("You haven't spent anything yet")),
                  );
                }
                return SpendingOverview(controller.spendingData);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _allFeature() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCircularButton(
          icon: Icons.account_balance_wallet,
          label: 'Wallet',
          onTap: () {
            Get.toNamed(Routes.WALLET);
          },
        ),
        _buildCircularButton(
          icon: Icons.track_changes_rounded,
          label: 'PicPlan',
          onTap: () {
            Get.toNamed(Routes.PICPLAN);
          },
        ),
        _buildCircularButton(
          icon: Icons.bar_chart,
          label: 'Report',
          onTap: () {
            Get.toNamed(Routes.REPORT);
          },
        ),
        _buildCircularButton(
          icon: Icons.keyboard_voice_rounded,
          label: 'PicVoice',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.brandColor.brandColor200,
            child: Icon(
              icon,
              color: AppColors.brandColor.brandColor900,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class SpendingWeek extends StatelessWidget {
  const SpendingWeek({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'You spent ',
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.secondary,
        ),
        children: [
          TextSpan(
            text: controller.totalSpending.isEmpty
                ? 'Rp. -'
                : 'Rp. ${(controller.totalSpending["total_week"] as num).toInt()}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.error.errorColor500,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' this week',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class SpendingHeader extends StatelessWidget {
  const SpendingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Spending Overview',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(TransactionHistoryView());
          },
          child: Row(
            children: [
              Text(
                'More',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.neutral.neutralColor600,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.neutral.neutralColor600,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(
              "assets/images/picbudget logo primary.png",
            )),
        SizedBox(width: 16),
        Text(
          'Hi, PicPlanners ✋',
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class SpendingOverview extends StatelessWidget {
  final List<Map<String, dynamic>> spendingData;

  const SpendingOverview(this.spendingData, {super.key});

  @override
  Widget build(BuildContext context) {
    int total =
        spendingData.map((e) => e['amount'] as int).reduce((a, b) => a + b);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.neutral.neutralColor600,
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rp. $total',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: double.infinity,
                  child: Row(
                    children: spendingData.map((data) {
                      return Expanded(
                        flex: data['amount'] as int,
                        child: Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            color: _hexToColor(data['color']),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  children: spendingData.map((data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: _hexToColor(data['color']),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "${data['category']}",
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.neutral.neutralColor900,
                              ),
                            ),
                          ),
                          Text(
                            "Rp. ${data['amount']}",
                            style: AppTypography.labelMedium.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceFirst('#', '');
    return Color(int.parse('0xFF$hexColor'));
  }
}
