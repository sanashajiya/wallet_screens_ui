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

  const TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions
          .map(
            (tx) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          final repo = WalletRepositoryImpl();
          final usecase = GetTransactionDetail(repo);

          return BlocProvider(
            create: (_) => TransactionDetailBloc(
              getTransactionDetail: usecase,
            )..add(TransactionDetailStarted(tx.id)),
            child: TransactionDetailPage(transactionId: tx.id),
          );
        },
      ),
    );
                },
                child: RoundedCard(
                  backgroundColor: Colors.white,
                  borderRadius: 18,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.softBackground,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_rounded,
                          size: 22,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.title,
                              style: AppTextStyles.bodyBold,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              tx.subtitle,
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (tx.isIncome ? '+ ' : '- ') +
                                tx.amount.toStringAsFixed(2),
                            style: tx.isIncome
                                ? AppTextStyles.amountPositive
                                : AppTextStyles.amountNegative,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(tx.date),
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String _formatDate(DateTime date) {
    // For now, simple format like "Today" / "Yesterday" / "2 days ago"
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '${difference} days ago';
  }
}
