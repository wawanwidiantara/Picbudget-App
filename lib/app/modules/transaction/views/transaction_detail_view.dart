import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/data/models/label.dart';
import 'package:picbudget_app/app/modules/transaction/controllers/transaction_detail_controller.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      backgroundColor: AppColors.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Detail Transaction',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final transaction = controller.transactionDetail.value;
                    final transactionItems =
                        controller.transactionItems.toList();

                    if (transaction == null) {
                      return Center(
                          child: Text('No transaction details available.'));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${transaction.id}',
                            style: TextStyle(fontSize: 16)),
                        Text('Type: ${transaction.type}',
                            style: TextStyle(fontSize: 16)),
                        Text('Amount: ${transaction.amount}',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            'Date: ${transaction.getFormattedTransactionDate()}',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 16),
                        Text('Labels:',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 0.0,
                          children: controller.availableLabels.map((label) {
                            final isSelected =
                                controller.selectedLabels.contains(label);

                            return Theme(
                              data: Theme.of(context).copyWith(
                                splashFactory: NoSplash
                                    .splashFactory, // Disable ripple effect
                              ),
                              child: ChoiceChip(
                                label: Text(
                                  "${label.emoticon} ${label.name}",
                                  style: AppTypography.labelMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.secondary
                                        : AppColors.secondary,
                                  ),
                                ),
                                backgroundColor: AppColors.white,
                                selectedColor:
                                    AppColors.brandColor.brandColor25,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.neutral.neutralColor600,
                                    width: 1.5, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      20), // Rounded corners
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  controller.toggleLabelSelection(label);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        if (transactionItems.isNotEmpty) ...[
                          SizedBox(height: 16),
                          Text('Items:', style: TextStyle(fontSize: 16)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: transactionItems.length,
                            itemBuilder: (context, index) {
                              final item = transactionItems[index];
                              return ListTile(
                                title: Text(item.itemName),
                                subtitle: Text(
                                    'Price: ${item.itemPrice.toStringAsFixed(2)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        final updatedData = await showDialog<
                                            Map<String, String>>(
                                          context: context,
                                          builder: (ctx) {
                                            final nameController =
                                                TextEditingController(
                                                    text: item.itemName);
                                            final priceController =
                                                TextEditingController(
                                                    text: item.itemPrice
                                                        .toStringAsFixed(2));
                                            return AlertDialog(
                                              title: Text('Edit Item'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: nameController,
                                                    decoration: InputDecoration(
                                                        labelText: 'Item Name'),
                                                  ),
                                                  TextField(
                                                      controller:
                                                          priceController,
                                                      decoration:
                                                          InputDecoration(
                                                              labelText:
                                                                  'Item Price'),
                                                      keyboardType:
                                                          TextInputType.number),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () =>
                                                      Navigator.of(ctx)
                                                          .pop(null),
                                                ),
                                                TextButton(
                                                  child: Text('Save'),
                                                  onPressed: () =>
                                                      Navigator.of(ctx).pop({
                                                    'name': nameController.text,
                                                    'price':
                                                        priceController.text,
                                                  }),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (updatedData != null &&
                                            updatedData['name'] != null &&
                                            updatedData['price'] != null) {
                                          final updatedPrice = double.tryParse(
                                              updatedData['price']!);
                                          if (updatedPrice != null) {
                                            await controller
                                                .updateTransactionItem(
                                              item.id,
                                              updatedData['name']!,
                                              updatedPrice,
                                            );
                                          } else {
                                            Get.snackbar('Error',
                                                'Invalid price entered');
                                          }
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () async {
                                        final confirm = await showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text('Delete Item'),
                                            content: Text(
                                                'Are you sure you want to delete this item?'),
                                            actions: [
                                              TextButton(
                                                child: Text('Cancel'),
                                                onPressed: () =>
                                                    Navigator.of(ctx)
                                                        .pop(false),
                                              ),
                                              TextButton(
                                                child: Text('Delete'),
                                                onPressed: () =>
                                                    Navigator.of(ctx).pop(true),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          await controller
                                              .deleteTransactionItem(item.id);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ] else
                          SizedBox()
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
