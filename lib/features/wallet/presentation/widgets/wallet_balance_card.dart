import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/primary_button.dart';
import 'package:wallet_screens_ui/core/widgets/rounded_card.dart';

class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final String currency;

  const WalletBalanceCard({
    super.key,
    required this.balance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      useGradient: true,
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Balance',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.softBackground.withAlpha(128),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: AppColors.textSecondary.withAlpha(200),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$currency ${_formatBalance(balance)}',
            style: AppTextStyles.balance.copyWith(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Send',
                  height: 44,
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: PrimaryButton(
                  label: 'Request',
                  outlined: true,
                  height: 44,
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatBalance(double value) {
    // Format with commas: 25430.00
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$intPart.${parts[1]}';
  }
}
