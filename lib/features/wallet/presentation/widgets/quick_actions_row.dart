
import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/rounded_card.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _QuickActionItem(
          icon: Icons.send_rounded,
          label: 'Transfer',
          backgroundColor: AppColors.quickTransfer,
        ),
        SizedBox(width: 12),
        _QuickActionItem(
          icon: Icons.account_balance_wallet_rounded,
          label: 'Top Up',
          backgroundColor: AppColors.quickTopUp,
        ),
        SizedBox(width: 12),
        _QuickActionItem(
          icon: Icons.receipt_long_rounded,
          label: 'Payment',
          backgroundColor: AppColors.quickPayment,
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RoundedCard(
        backgroundColor: backgroundColor,
        borderRadius: 18,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: AppColors.textPrimary),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
