import 'package:flutter/material.dart';
import 'package:picbudget_app/app/core/constants/colors.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';

enum ButtonType { primary, secondary, tertiary, danger }

enum ButtonState { enabled, disabled, loading }

enum ButtonLayout { iconOnly, labelOnly, iconWithLabel }

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.state = ButtonState.enabled,
    this.layout = ButtonLayout.labelOnly,
    this.label = 'Button',
    this.icon,
    this.iconLeading = false,
  });

  final VoidCallback onPressed;
  final ButtonType type;
  final ButtonState state;
  final ButtonLayout layout;
  final String label;
  final bool iconLeading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    TextStyle textStyle;
    ButtonStyle buttonStyle;

    switch (type) {
      case ButtonType.tertiary:
        backgroundColor = AppColors.white;
        textStyle = AppTypography.bodyMedium.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        );
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side:
                BorderSide(color: AppColors.neutral.neutralColor500, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0, // Remove shadow
        );
        break;
      case ButtonType.danger:
        backgroundColor = state == ButtonState.enabled
            ? AppColors.error.errorColor500
            : AppColors.error.errorColor500;
        textStyle = AppTypography.bodyMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        );
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
      case ButtonType.secondary:
        backgroundColor = state == ButtonState.enabled
            ? AppColors.secondary
            : AppColors.secondary;
        textStyle = AppTypography.bodyMedium.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        );
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
      case ButtonType.primary:
      default:
        backgroundColor = state == ButtonState.enabled
            ? AppColors.primary
            : AppColors.primary;
        textStyle = AppTypography.bodyMedium.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        );
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: state == ButtonState.enabled ? onPressed : null,
        child: Text(
          label,
          style: textStyle,
        ),
      ),
    );
  }
}
