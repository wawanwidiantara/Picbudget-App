import 'package:get/get.dart';

import '../modules/PicScan/bindings/pic_scan_binding.dart';
import '../modules/PicScan/views/pic_scan_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/picplan/bindings/picplan_binding.dart';
import '../modules/picplan/views/picplan_view.dart';
import '../modules/picreport/bindings/picreport_binding.dart';
import '../modules/picreport/views/picreport_view.dart';
import '../modules/picvoice/bindings/picvoice_binding.dart';
import '../modules/picvoice/views/picvoice_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/views/wallet_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.PICPLAN,
      page: () => const PicplanView(),
      binding: PicplanBinding(),
    ),
    GetPage(
      name: _Paths.PICVOICE,
      page: () => const PicvoiceView(),
      binding: PicvoiceBinding(),
    ),
    GetPage(
      name: _Paths.PICREPORT,
      page: () => const PicreportView(),
      binding: PicreportBinding(),
    ),
    GetPage(
      name: _Paths.PIC_SCAN,
      page: () => const PicScanView(),
      binding: PicScanBinding(),
    ),
  ];
}
