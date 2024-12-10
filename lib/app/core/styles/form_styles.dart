import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:flutter/material.dart';

InputDecoration formStyle() {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
