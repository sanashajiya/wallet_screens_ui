import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/primary_button.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(30), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.warning.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.card_giftcard_rounded,
              color: AppColors.warning,
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Promo!',
                  style: AppTextStyles.bodyBold.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Get attractive cashback for every transaction.',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withAlpha(200),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          PrimaryButton(
            label: 'Get Promo',
            expanded: false,
            height: 38,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
