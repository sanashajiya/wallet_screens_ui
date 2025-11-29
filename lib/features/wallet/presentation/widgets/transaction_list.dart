import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_screens_ui/core/theme/app_colors.dart';
import 'package:wallet_screens_ui/core/theme/app_text_styles.dart';
import 'package:wallet_screens_ui/core/widgets/rounded_card.dart';
import 'package:wallet_screens_ui/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:wallet_screens_ui/features/wallet/domain/entities/transaction_entity.dart';
import 'package:wallet_screens_ui/features/wallet/domain/usecases/get_transaction_detail.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/blocs/transaction_detail/transaction_detail_bloc.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/blocs/transaction_detail/transaction_detail_event.dart';
import 'package:wallet_screens_ui/features/wallet/presentation/pages/transaction_detail_page.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionList({super.key, required this.transactions});

  // Map of transaction titles to icon data and colors
  static const _iconMap = {
    'Starbucks': _IconInfo(Icons.coffee, AppColors.txIconPurple),
    'Netflix': _IconInfo(Icons.play_arrow_rounded, AppColors.txIconRed),
    'Salary': _IconInfo(Icons.account_balance, AppColors.txIconGreen),
    'Uber': _IconInfo(Icons.directions_car, AppColors.txIconOrange),
    'default': _IconInfo(Icons.shopping_bag_rounded, AppColors.txIconBlue),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions
          .map((tx) => _buildTransactionItem(context, tx))
          .toList(),
    );
  }

  Widget _buildTransactionItem(BuildContext context, TransactionEntity tx) {
    final iconInfo = _iconMap[tx.title] ?? _iconMap['default']!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _navigateToDetail(context, tx),
        child: RoundedCard(
          backgroundColor: Colors.white,
          borderRadius: 18,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: iconInfo.color.withAlpha(30),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(iconInfo.icon, size: 22, color: iconInfo.color),
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
                      tx.subtitle,
                      style: AppTextStyles.caption.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  const SizedBox(height: 3),
                  Text(
                    _formatDate(tx.date),
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, TransactionEntity tx) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          final repo = WalletRepositoryImpl();
          final usecase = GetTransactionDetail(repo);
          return BlocProvider(
            create: (_) =>
                TransactionDetailBloc(getTransactionDetail: usecase)
                  ..add(TransactionDetailStarted(tx.id)),
            child: TransactionDetailPage(transactionId: tx.id),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '$difference days ago';
  }
}

class _IconInfo {
  final IconData icon;
  final Color color;
  const _IconInfo(this.icon, this.color);
}
