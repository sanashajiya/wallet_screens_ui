import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';

class WalletHeader extends StatelessWidget {
  final String userName;

  const WalletHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning 👋',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textLight.withAlpha(230),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userName,
                style: AppTextStyles.screenTitle.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }
}
