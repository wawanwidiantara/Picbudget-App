import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/colors.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: AppColors.primaryBlack,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlack,
        ),
        body: Obx(() => Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      height: Get.height * 0.4,
                      color: AppColors.primaryBlack,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: AppColors.mainBackground,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  "assets/images/picbudget logo.png",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              controller.user.isEmpty
                                  ? "User"
                                  : controller.user['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.user.isEmpty
                                  ? "Email"
                                  : controller.user['email'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ])),
                ),
                Positioned(
                  top: Get.height * 0.35,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Get.height * 0.55,
                    decoration: const BoxDecoration(
                      color: AppColors.mainBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlack,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  controller.logout();
                                  FocusScope.of(context).unfocus();
                                },
                                child: const Text("Logout",
                                    style: TextStyle(
                                        color: AppColors.mainBackground,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const BackArrowIcon(),
              ],
            )));
  }
}
