import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  final bool expanded;
  final double height;
  final BorderRadiusGeometry borderRadius;
  final Widget? leading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.expanded = true,
    this.height = 52,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: outlined
              ? AppTextStyles.buttonSecondary
              : AppTextStyles.button,
        ),
      ],
    );

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: outlined ? 0 : 4,
        backgroundColor:
            outlined ? Colors.white : AppColors.primary,
        foregroundColor:
            outlined ? AppColors.primary : AppColors.textLight,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: outlined
              ? const BorderSide(color: AppColors.primary, width: 1.4)
              : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      child: child,
    );

    if (!expanded) {
      return SizedBox(height: height, child: button);
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: button,
    );
  }
}
