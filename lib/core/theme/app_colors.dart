import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background gradients (purple → pink)
  static const Color gradientStart = Color(0xFF6C5DD3);
  static const Color gradientMiddle = Color(0xFF8A6BE8);
  static const Color gradientEnd = Color(0xFFF8A7C4);

  // Cards / surfaces
  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x1A000000); // 10% black
  static const Color softBackground = Color(0xFFF5F6FA);

  // Text
  static const Color textPrimary = Color(0xFF1F1F39);
  static const Color textSecondary = Color(0xFF6E6E8A);
  static const Color textLight = Colors.white;

  // Accent colors
  static const Color primary = Color(0xFF6C5DD3);
  static const Color primaryDark = Color(0xFF5140B5);
  static const Color success = Color(0xFF32C48D);
  static const Color warning = Color(0xFFF5B93A);
  static const Color danger = Color(0xFFE45865);

  // Quick action tile backgrounds (soft pastel)
  static const Color quickTransfer = Color(0xFFFCE7F3);
  static const Color quickTopUp = Color(0xFFFFF4E5);
  static const Color quickPayment = Color(0xFFE7F5F9);

  // Statistics colors
  static const Color income = Color(0xFF32C48D);
  static const Color expense = Color(0xFFE45865);

  // Borders
  static const Color divider = Color(0xFFE3E5EC);

  // Helpers
  static LinearGradient appBackgroundGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      gradientStart,
      gradientMiddle,
      gradientEnd,
    ],
  );

  static LinearGradient cardGradientSoft = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF7F7FF),
    ],
  );
}
