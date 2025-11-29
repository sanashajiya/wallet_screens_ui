// lib/features/wallet/presentation/pages/payment_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/rounded_card.dart';
import '../../domain/entities/payment_screen_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../blocs/payment/payment_bloc.dart';
import '../blocs/payment/payment_state.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.appBackgroundGradient,
        ),
        child: SafeArea(
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PaymentError) {
                return Center(child: Text(state.message));
              }
              if (state is PaymentLoaded) {
                return _PaymentContent(data: state.data);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _PaymentContent extends StatelessWidget {
  final PaymentScreenEntity data;

  const _PaymentContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(),
          const SizedBox(height: 20),
          _PaymentCard(data: data),
          const SizedBox(height: 10),
          _PageIndicator(),
          const SizedBox(height: 24),
          _StatisticSection(
            income: data.income,
            expense: data.expense,
          ),
          const SizedBox(height: 20),
          _HistoryList(history: data.history),
        ],
      ),
    );
  }
}

// ==== Widgets ====

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.18),
          ),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 8),
        Text(
          'Payment',
          style: AppTextStyles.screenTitle.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final PaymentScreenEntity data;

  const _PaymentCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(18),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFC8A2),
              Color(0xFFFEA4C8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Bill',
              style: AppTextStyles.caption.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.cardNumberMasked,
              style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.25),
                  ),
                  child: Text(
                    'Due in 3 days',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Amount Due',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${data.cardBalance.toStringAsFixed(2)}',
                      style: AppTextStyles.screenTitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Dot(isActive: true),
          const SizedBox(width: 6),
          _Dot(isActive: false),
          const SizedBox(width: 6),
          _Dot(isActive: false),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;

  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 14 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class _StatisticSection extends StatelessWidget {
  final double income;
  final double expense;

  const _StatisticSection({
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final total = income + expense;
    final incomeRatio = total == 0 ? 0.5 : income / total;

    return RoundedCard(
      backgroundColor: Colors.white,
      borderRadius: 28,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Statistic', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 16),
          Row(
            children: [
              _DonutChart(incomeRatio: incomeRatio),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    _LegendItem(
                      color: AppColors.income,
                      label: 'Income',
                      value: income,
                    ),
                    const SizedBox(height: 10),
                    _LegendItem(
                      color: AppColors.expense,
                      label: 'Expense',
                      value: expense,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  final double incomeRatio;

  const _DonutChart({required this.incomeRatio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: 1,
            strokeWidth: 10,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.expense,
            ),
            backgroundColor: Colors.transparent,
          ),
          CircularProgressIndicator(
            value: incomeRatio,
            strokeWidth: 10,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.income,
            ),
            backgroundColor: Colors.transparent,
          ),
          Text(
            '${(incomeRatio * 100).round()}%',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final double value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.body,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: AppTextStyles.bodyBold,
        ),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  final List<TransactionEntity> history;

  const _HistoryList({required this.history});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('History', style: AppTextStyles.sectionTitle),
            const Spacer(),
            Text(
              'See More',
              style: AppTextStyles.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: history
              .map(
                (tx) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RoundedCard(
                    backgroundColor: Colors.white,
                    borderRadius: 18,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.softBackground,
                          child: const Icon(Icons.person,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx.title, style: AppTextStyles.bodyBold),
                              const SizedBox(height: 2),
                              Text(
                                _formatDate(tx.date),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (tx.isIncome ? '+ ' : '- ') +
                              tx.amount.toStringAsFixed(2),
                          style: tx.isIncome
                              ? AppTextStyles.amountPositive
                              : AppTextStyles.amountNegative,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthName(date.month)} ${date.year}';
  }

  String _monthName(int m) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec',
    ];
    return months[m - 1];
  }
}
