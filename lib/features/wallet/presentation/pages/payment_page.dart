import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
        decoration: BoxDecoration(gradient: AppColors.appBackgroundGradient),
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
          _StatisticSection(income: data.income, expense: data.expense),
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
          'Payment',
          style: AppTextStyles.screenTitle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: AppColors.paymentCardGradient,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDA4C8).withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone Bill',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withAlpha(220),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.cardNumberMasked,
            style: AppTextStyles.bodyBold.copyWith(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withAlpha(60),
                ),
                child: Text(
                  'Due in 3 days',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
                      color: Colors.white.withAlpha(220),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${_formatAmount(data.cardBalance)}',
                    style: AppTextStyles.balance.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return '$intPart.${parts[1]}';
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
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isActive ? Colors.white : Colors.white.withAlpha(128),
      ),
    );
  }
}

class _StatisticSection extends StatelessWidget {
  final double income;
  final double expense;

  const _StatisticSection({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    final total = income + expense;
    final incomeRatio = total == 0 ? 0.5 : income / total;

    return RoundedCard(
      backgroundColor: Colors.white,
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistic',
            style: AppTextStyles.sectionTitle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _DonutChart(incomeRatio: incomeRatio),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _LegendItem(
                      color: AppColors.income,
                      label: 'Income',
                      value: income,
                    ),
                    const SizedBox(height: 14),
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
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 12,
              strokeCap: StrokeCap.round,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.expense,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              value: incomeRatio,
              strokeWidth: 12,
              strokeCap: StrokeCap.round,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.income),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            '${(incomeRatio * 100).round()}%',
            style: AppTextStyles.bodyBold.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
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
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: AppTextStyles.body.copyWith(fontSize: 14)),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: AppTextStyles.bodyBold.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  final List<TransactionEntity> history;

  const _HistoryList({required this.history});

  // Map of transaction titles to colors
  static const _colorMap = {
    'Starbucks': AppColors.txIconPurple,
    'Netflix': AppColors.txIconRed,
    'Salary': AppColors.txIconGreen,
    'Uber': AppColors.txIconOrange,
    'default': AppColors.txIconBlue,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'History',
              style: AppTextStyles.sectionTitle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                'See More',
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Column(children: history.map((tx) => _buildHistoryItem(tx)).toList()),
      ],
    );
  }

  Widget _buildHistoryItem(TransactionEntity tx) {
    final color = _colorMap[tx.title] ?? _colorMap['default']!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RoundedCard(
        backgroundColor: Colors.white,
        borderRadius: 20,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withAlpha(40),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getIconForTransaction(tx.title),
                color: color,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatDate(tx.date),
                    style: AppTextStyles.caption.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${tx.isIncome ? '+' : '-'} ${tx.amount.toStringAsFixed(2)}',
              style: tx.isIncome
                  ? AppTextStyles.amountPositive.copyWith(
                      fontWeight: FontWeight.w600,
                    )
                  : AppTextStyles.amountNegative.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTransaction(String title) {
    switch (title) {
      case 'Starbucks':
        return Icons.coffee;
      case 'Netflix':
        return Icons.play_arrow_rounded;
      case 'Salary':
        return Icons.account_balance;
      case 'Uber':
        return Icons.directions_car;
      default:
        return Icons.shopping_bag_rounded;
    }
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
