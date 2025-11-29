import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_screens_ui/core/widgets/app_bottom_nav_bar.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/pages/payment_page.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../blocs/transaction_detail/transaction_detail_bloc.dart';
import '../blocs/transaction_detail/transaction_detail_state.dart';

class TransactionDetailPage extends StatelessWidget {
  final String transactionId;

  const TransactionDetailPage({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        items: const [
          AppBottomNavItem(icon: Icons.home_rounded, label: 'Home'),
          AppBottomNavItem(icon: Icons.chat_bubble_rounded, label: 'Duitin'),
          AppBottomNavItem(icon: Icons.pie_chart_rounded, label: 'Statistic'),
          AppBottomNavItem(icon: Icons.person_rounded, label: 'Profile'),
        ],
        currentIndex: 1, // 👉 second item highlighted
        onItemSelected: (index) {
          // optional: handle tab navigation later
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (index == 2) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const PaymentPage()));
          }
        },
      ),

      body: Container(
        decoration: BoxDecoration(gradient: AppColors.appBackgroundGradient),
        child: SafeArea(
          child: BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
            builder: (context, state) {
              if (state is TransactionDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TransactionDetailError) {
                return Center(child: Text(state.message));
              }
              if (state is TransactionDetailLoaded) {
                final tx = state.transaction;

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TopBar(),
                            const SizedBox(height: 16),
                            _AssistantTextHeader(transaction: tx),
                            const SizedBox(height: 16),
                            const _SuggestedActionsRow(),
                            const SizedBox(height: 20),
                            const _UserChatBubble(
                              text: 'Yes, please show me the details.',
                            ),
                            const SizedBox(height: 14),
                            _AssistantChatBubble(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Here's the transaction summary:",
                                    style: AppTextStyles.bodyBold,
                                  ),
                                  const SizedBox(height: 12),
                                  _TransactionSummaryCard(transaction: tx),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Would you like to dispute this payment or add a note to it?',
                                    style: AppTextStyles.body,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const _ChatInputBar(),
                    const SizedBox(height: 5),
                  ],
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

// ==== SMALL WIDGETS BELOW ====

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'Detail',
          style: AppTextStyles.screenTitle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AssistantTextHeader extends StatelessWidget {
  final dynamic transaction; // TransactionEntity

  const _AssistantTextHeader({required this.transaction});

  @override
  Widget build(BuildContext context) {
    // For now, use static amount/date text similar to design.
    return Text(
      'Your balance decreased because of a '
      '\$${transaction.amount.toStringAsFixed(2)} payment to '
      '${transaction.title} on ${_formatDate(transaction.date)}. '
      'Would you like me to show you the transaction details?',
      style: AppTextStyles.body.copyWith(color: Colors.white),
    );
  }

  String _formatDate(DateTime date) {
    // Just simple, e.g. "22 Sep 2025"
    return '${date.day} ${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m - 1];
  }
}

class _SuggestedActionsRow extends StatelessWidget {
  const _SuggestedActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _SuggestedChip(label: 'View Transaction History', icon: Icons.list_alt),
        SizedBox(width: 10),
        _SuggestedChip(label: 'Analyze Money', icon: Icons.bar_chart_rounded),
      ],
    );
  }
}

class _SuggestedChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SuggestedChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserChatBubble extends StatelessWidget {
  final String text;

  const _UserChatBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _AssistantChatBubble extends StatelessWidget {
  final Widget child;

  const _AssistantChatBubble({required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}

class _TransactionSummaryCard extends StatelessWidget {
  final dynamic transaction; // TransactionEntity

  const _TransactionSummaryCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.txIconPurple.withAlpha(40),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.txIconPurple,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 3),
                Text(
                  _formatDate(transaction.date),
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '- ${transaction.amount.toStringAsFixed(2)}',
            style: AppTextStyles.amountNegative.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m - 1];
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(bottom: 12, top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ask anything...',
                  hintStyle: AppTextStyles.caption,
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_none_rounded),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
          ],
        ),
      ),
    );
  }
}
