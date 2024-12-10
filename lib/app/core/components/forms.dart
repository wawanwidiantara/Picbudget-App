import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/core/styles/form_styles.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.isObsecured,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final bool isObsecured;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.titleSmall),
        const SizedBox(height: 8),
        SizedBox(
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: isObsecured,
            keyboardType: keyboardType,
            style: AppTypography.bodyMedium,
            decoration: formStyle(),
          ),
        ),
      ],
    );
  }
}
