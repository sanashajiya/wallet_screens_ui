import 'package:flutter/material.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/primary_button.dart';
import 'package:wallet_screens_ui/core/widgets/rounded_card.dart';
class PromoBanner extends StatelessWidget {
  const PromoBanner();

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      backgroundColor: Colors.white.withOpacity(0.15),
      borderRadius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Promo!',
                  style: AppTextStyles.bodyBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Get attractive cashback for every transaction.',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          PrimaryButton(
            label: 'Get Promo',
            expanded: false,
            height: 40,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
