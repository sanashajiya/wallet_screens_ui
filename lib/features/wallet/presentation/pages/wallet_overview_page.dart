// lib/features/wallet/presentation/pages/wallet_overview_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_screens_ui/core/widgets/app_bottom_nav_bar.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/pages/payment_page.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/widgets/promo_banner.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/widgets/quick_actions_row.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/widgets/transaction_list.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/widgets/wallet_balance_card.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/widgets/wallet_header.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../blocs/wallet_overview/wallet_overview_bloc.dart';
import '../blocs/wallet_overview/wallet_overview_state.dart';
import '../blocs/wallet_overview/wallet_overview_event.dart';

class WalletOverviewPage extends StatelessWidget {
  const WalletOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        items: const [
          AppBottomNavItem(icon: Icons.home_rounded, label: 'Home'),
          AppBottomNavItem(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Duitin',
          ),
          // Placeholder for center floating button
          AppBottomNavItem(icon: Icons.qr_code_scanner, label: ''),
          AppBottomNavItem(icon: Icons.pie_chart_rounded, label: 'Statistic'),
          AppBottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
        currentIndex: 0,
        onItemSelected: (index) {
          // Adjust index for items after center button
          final adjustedIndex = index > 2 ? index - 1 : index;
          if (adjustedIndex == 1) {
            // Go to Duitin
          } else if (adjustedIndex == 2) {
            // Go to Statistic / Payment (Screen 3)
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const PaymentPage()));
          }
        },
        onCenterButtonPressed: () {
          // Handle scan/QR action
        },
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackgroundGradient),
        child: SafeArea(
          child: BlocBuilder<WalletOverviewBloc, WalletOverviewState>(
            builder: (context, state) {
              if (state is WalletOverviewLoading ||
                  state is WalletOverviewInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WalletOverviewError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.message, style: AppTextStyles.body),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Retry',
                        expanded: false,
                        onPressed: () {
                          context.read<WalletOverviewBloc>().add(
                            const WalletOverviewRefreshRequested(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is WalletOverviewLoaded) {
                final data = state.data;
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WalletHeader(userName: data.userName),
                      const SizedBox(height: 20),
                      WalletBalanceCard(
                        balance: data.balance,
                        currency: data.currency,
                      ),
                      const SizedBox(height: 16),
                      const PromoBanner(),
                      const SizedBox(height: 20),
                      const QuickActionsRow(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transactions',
                            style: AppTextStyles.sectionTitle.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to full transactions list
                            },
                            child: Text(
                              'See More',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textLight.withAlpha(200),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TransactionList(transactions: data.recentTransactions),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
