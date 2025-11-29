import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Large wallet balance number
  static const TextStyle balance = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );

  // Screen title (e.g., "Payment")
  static const TextStyle screenTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Section titles (e.g., "Quick Actions", "Statistic", "History")
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Regular body text
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Bold body
  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Small label (e.g., dates, chip labels)
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Amount text in cards / history
  static const TextStyle amountPositive = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.income,
  );

  static const TextStyle amountNegative = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.expense,
  );

  // Buttons
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
}
