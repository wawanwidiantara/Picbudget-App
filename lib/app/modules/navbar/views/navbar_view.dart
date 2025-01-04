import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picbudget_app/app/core/components/snackbar.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/modules/PicScan/controllers/extract_receipt_controller.dart';
import 'package:picbudget_app/app/modules/home/views/home_view.dart';
import 'package:picbudget_app/app/modules/profile/views/profile_view.dart';
import 'package:picbudget_app/app/modules/transaction/views/transaction_view.dart';
import 'package:picbudget_app/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';

import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});
  @override
  Widget build(BuildContext context) {
    final extract = Get.put(ExtractReceiptController());
    final wallet = Get.put(WalletController());
    wallet.fetchWallets();

    return GetBuilder<NavbarController>(builder: (controller) {
      return Scaffold(
        body: FadeIndexedStack(
          beginOpacity: 0.0,
          endOpacity: 1.0,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 100),
          index: controller.tabIndex,
          children: const [
            HomeView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              enableFeedback: true,
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.secondary,
              unselectedItemColor: AppColors.neutral.neutralColor600,
              selectedFontSize: 12,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home),
                  icon: Icon(
                    Icons.home_outlined,
                    color: AppColors.neutral.neutralColor600,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person),
                  icon: Icon(Icons.person_outline_rounded,
                      color: AppColors.neutral.neutralColor600),
                  label: 'Profile',
                ),
              ],
            ),
            Positioned(
              top: -30, // Adjust as needed to position the button
              left: MediaQuery.of(context).size.width / 2 - 30, // Center button
              child: GestureDetector(
                onTap: () {
                  final walletId = wallet.getFirstWalletId();
                  if (walletId != null) {
                    extract.getReceiptImage(ImageSource.camera, walletId);
                  } else {
                    wallet.fetchWallets();
                    if (walletId != null) {
                      extract.getReceiptImage(ImageSource.camera, walletId);
                    } else {
                      SnackBarWidget.showSnackBar(
                        'Transaksi Gagal',
                        'Error: No wallet found.',
                        'err',
                      );
                    }
                  }
                },
                onLongPress: () {
                  final walletId = wallet.getFirstWalletId();
                  if (walletId != null) {
                    extract.getReceiptImage(ImageSource.gallery, walletId);
                  } else {
                    wallet.fetchWallets();
                    if (walletId != null) {
                      extract.getReceiptImage(ImageSource.camera, walletId);
                    } else {
                      SnackBarWidget.showSnackBar(
                        'Transaksi Gagal',
                        'Error: No wallet found.',
                        'err',
                      );
                    }
                  }
                },
                onDoubleTap: () {
                  Get.to(() => TransactionView(),
                      arguments: wallet.getFirstWalletId());
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
