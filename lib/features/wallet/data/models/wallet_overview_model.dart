// lib/features/wallet/data/models/wallet_overview_model.dart
import '../../domain/entities/wallet_overview_entity.dart';
import '../../domain/entities/transaction_entity.dart';

class WalletOverviewModel {
  final String userName;
  final double balance;
  final String currency;
  final bool isBalanceHidden;
  final List<TransactionEntity> recentTransactions;

  const WalletOverviewModel({
    required this.userName,
    required this.balance,
    required this.currency,
    required this.isBalanceHidden,
    required this.recentTransactions,
  });

  WalletOverviewEntity toEntity() {
    return WalletOverviewEntity(
      userName: userName,
      balance: balance,
      currency: currency,
      isBalanceHidden: isBalanceHidden,
      recentTransactions: recentTransactions,
    );
  }
}
