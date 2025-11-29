import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppBottomNavItem {
  final IconData icon;
  final String label;

  const AppBottomNavItem({
    required this.icon,
    required this.label,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  }) : assert(items.length >= 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final bool isSelected = index == currentIndex;

            return InkWell(
              onTap: () => onItemSelected(index),
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 22,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
