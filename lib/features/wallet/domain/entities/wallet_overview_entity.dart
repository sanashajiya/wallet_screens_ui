// lib/features/wallet/domain/entities/wallet_overview_entity.dart
import 'transaction_entity.dart';

class WalletOverviewEntity {
  final String userName;                // e.g. "Prakthis"
  final double balance;                 // e.g. 25430.00
  final String currency;                // e.g. "USD"
  final bool isBalanceHidden;
  final List<TransactionEntity> recentTransactions;

  const WalletOverviewEntity({
    required this.userName,
    required this.balance,
    required this.currency,
    required this.isBalanceHidden,
    required this.recentTransactions,
  });
}
