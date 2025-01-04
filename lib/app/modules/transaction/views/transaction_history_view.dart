import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:picbudget_app/app/modules/transaction/views/transaction_detail_view.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';

class TransactionHistoryView extends GetView {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final walletController = Get.put(WalletController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.secondary,
      body: Obx(() {
        // Group transactions by date
        final groupedTransactions =
            _groupTransactionsByDate(controller.transactions);

        if (groupedTransactions.isEmpty) {
          controller.fetchTransactions();
          return Center(
            child: Text(
              'No transactions found',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: groupedTransactions.entries.map((entry) {
                        final date = entry.key; // Date header
                        final transactions = entry.value; // Transactions list

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                                date), // Dynamic header for each date
                            const SizedBox(height: 24),
                            _buildTransactionList(
                                transactions, walletController),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Group transactions by date
  Map<String, List<dynamic>> _groupTransactionsByDate(List transactions) {
    final Map<String, List<dynamic>> grouped = {};
    for (var transaction in transactions) {
      final formattedDate =
          DateFormat('EEEE, dd-MM-yyyy').format(transaction.transactionDate);

      if (!grouped.containsKey(formattedDate)) {
        grouped[formattedDate] = [];
      }
      grouped[formattedDate]!.add(transaction);
    }
    return grouped;
  }

  /// Builds the section header for each date
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Builds the transaction list (preserves the existing layout)
  Widget _buildTransactionList(
      List transactions, WalletController walletController) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return GestureDetector(
          onTap: () {
            Get.to(() => TransactionDetailView(), arguments: transaction.id);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.neutral.neutralColor700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Image.asset(
                              "assets/images/picbudget logo white.png"),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.type,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          transaction.getFormattedTime(),
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Rp. ${transaction.amount}',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.error.errorColor500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
