import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/primary_button.dart';
import 'package:wallet_screens_ui/core/widgets/rounded_card.dart';
class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final String currency;

  const WalletBalanceCard({
    required this.balance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      useGradient: true,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Balance',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 18,
                color: AppColors.textSecondary.withOpacity(0.8),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$currency ${balance.toStringAsFixed(2)}',
            style: AppTextStyles.balance.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Send',
                  height: 44,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'Request',
                  outlined: true,
                  height: 44,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
