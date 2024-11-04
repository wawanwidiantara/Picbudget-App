import 'package:flutter/material.dart';
import 'package:picbudget_app/app/constans/colors.dart';

// import 'app_colors.dart';
// import 'app_font_size.dart';

class AppTextStyle {
  // ----------Black----------//

  static const xSmallBlack = TextStyle(
    fontSize: 12,
    color: AppColors.primaryBlack,
  );

  static const xSmallWhite = TextStyle(
      fontSize: 12,
      color: AppColors.mainBackground,
      fontWeight: FontWeight.bold);

  static const xMediumWhite = TextStyle(
      fontSize: 16,
      color: AppColors.mainBackground,
      fontWeight: FontWeight.bold);

  static const xBigWhite = TextStyle(
      fontSize: 24,
      color: AppColors.mainBackground,
      fontWeight: FontWeight.bold);
}
