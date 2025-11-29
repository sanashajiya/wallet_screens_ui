import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _QuickActionItem(
          icon: Icons.send_rounded,
          label: 'Transfer',
          backgroundColor: AppColors.quickTransfer,
          iconColor: Color(0xFFE879A9),
        ),
        _QuickActionItem(
          icon: Icons.account_balance_wallet_rounded,
          label: 'Top Up',
          backgroundColor: AppColors.quickTopUp,
          iconColor: Color(0xFFF59E0B),
        ),
        _QuickActionItem(
          icon: Icons.receipt_long_rounded,
          label: 'Payment',
          backgroundColor: AppColors.quickPayment,
          iconColor: Color(0xFF3B82F6),
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withAlpha(100),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, size: 25, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
