import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background gradients (purple → pink) - refined to match original
  static const Color gradientStart = Color(0xFF7B6CF6);
  static const Color gradientMiddle = Color(0xFFA78BFA);
  static const Color gradientEnd = Color(0xFFFDAED8);

  // Cards / surfaces
  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x14000000); // subtle shadow
  static const Color softBackground = Color(0xFFF5F6FA);

  // Text
  static const Color textPrimary = Color(0xFF1F1F39);
  static const Color textSecondary = Color(0xFF7B7B93);
  static const Color textLight = Colors.white;

  // Accent colors
  static const Color primary = Color(0xFF7B6CF6);
  static const Color primaryDark = Color(0xFF5B4CD3);
  static const Color success = Color(0xFF32C48D);
  static const Color warning = Color(0xFFF5B93A);
  static const Color danger = Color(0xFFE45865);

  // Quick action tile backgrounds (soft pastel) - matching original
  static const Color quickTransfer = Color(0xFFFCE7F3); // pink
  static const Color quickTopUp = Color(0xFFFFF7ED); // light orange
  static const Color quickPayment = Color(0xFFE0F2FE); // light blue

  // Statistics colors
  static const Color income = Color(0xFF32C48D);
  static const Color expense = Color(0xFFE45865);

  // Transaction icon backgrounds (circular, colored)
  static const Color txIconPurple = Color(0xFF9B87F5);
  static const Color txIconRed = Color(0xFFE45865);
  static const Color txIconGreen = Color(0xFF32C48D);
  static const Color txIconOrange = Color(0xFFF59E0B);
  static const Color txIconBlue = Color(0xFF3B82F6);

  // Borders
  static const Color divider = Color(0xFFE3E5EC);

  // Helpers
  static LinearGradient appBackgroundGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientMiddle, gradientEnd],
  );

  static LinearGradient cardGradientSoft = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF9F9FF)],
  );

  // Payment card gradient (coral/pink)
  static LinearGradient paymentCardGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFEB08A), Color(0xFFFDA4C8)],
  );
}
