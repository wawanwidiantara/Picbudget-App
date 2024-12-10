import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';

InputDecoration formStyle(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
    hintText: hintText,
    hintStyle: AppTypography.bodyMedium
        .copyWith(color: AppColors.neutral.neutralColor700),
    filled: true,
    fillColor: AppColors.white,
    focusColor: AppColors.neutral.neutralColor500,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error.errorColor500),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error.errorColor500),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: AppColors.neutral.neutralColor500, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: AppColors.neutral.neutralColor500, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

InputDecoration otpFormStyle() {
  return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.error.errorColor500, width: 1.5),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.error.errorColor500, width: 2.0),
      ),
      counterText: '');
}
