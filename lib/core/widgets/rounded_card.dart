import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final bool useGradient;
  final Color? backgroundColor;
  final BoxBorder? border;
  final VoidCallback? onTap;

  const RoundedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = 20,
    this.useGradient = false,
    this.backgroundColor,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: useGradient ? null : (backgroundColor ?? AppColors.cardBackground),
        gradient: useGradient ? AppColors.cardGradientSoft : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: child,
    );

    if (onTap == null) return card;

    return GestureDetector(
      onTap: onTap,
      child: card,
    );
  }
}
