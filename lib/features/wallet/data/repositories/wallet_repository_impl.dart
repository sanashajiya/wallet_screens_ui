// lib/features/wallet/data/repositories/wallet_repository_impl.dart
import 'dart:async';

import '../../domain/entities/wallet_overview_entity.dart';
import '../../domain/entities/payment_screen_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../models/payment_screen_model.dart';
import '../models/transaction_model.dart';
import '../models/wallet_overview_model.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl();

  // Mock transactions
  List<TransactionModel> get _mockTransactions {
    final now = DateTime.now();
    return [
      TransactionModel(
        id: '1',
        title: 'Starbucks',
        subtitle: 'Coffee break',
        date: now.subtract(const Duration(hours: 3)),
        amount: 12.50,
        isIncome: false,
      ),
      TransactionModel(
        id: '2',
        title: 'Netflix',
        subtitle: 'Monthly subscription',
        date: now.subtract(const Duration(days: 1)),
        amount: 9.99,
        isIncome: false,
      ),
      TransactionModel(
        id: '3',
        title: 'Salary',
        subtitle: 'Company Ltd.',
        date: now.subtract(const Duration(days: 2)),
        amount: 2500.00,
        isIncome: true,
      ),
      TransactionModel(
        id: '4',
        title: 'Uber',
        subtitle: 'Trip to office',
        date: now.subtract(const Duration(days: 2, hours: 5)),
        amount: 6.40,
        isIncome: false,
      ),
    ];
  }

  @override
  Future<WalletOverviewEntity> getWalletOverview() async {
    await Future.delayed(const Duration(milliseconds: 400)); // simulate API

    final transactions = _mockTransactions
        .take(3)
        .map((model) => model.toEntity())
        .toList();

    final model = WalletOverviewModel(
      userName: 'Prakthis',
      balance: 25430.00,
      currency: 'USD',
      isBalanceHidden: false,
      recentTransactions: transactions,
    );

    return model.toEntity();
  }

  @override
  Future<PaymentScreenEntity> getPaymentScreenData() async {
    await Future.delayed(const Duration(milliseconds: 400));

    final history = _mockTransactions.map((t) => t.toEntity()).toList();

    final model = PaymentScreenModel(
      cardHolderName: 'Prakthis',
      cardNumberMasked: '**** **** **** 1234',
      expiry: '12/26',
      cardBalance: 25430.00,
      income: 4500.00,
      expense: 2150.00,
      history: history,
    );

    return model.toEntity();
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockTransactions.map((t) => t.toEntity()).toList();
  }

  @override
  Future<TransactionEntity> getTransactionDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final tx = _mockTransactions.firstWhere(
      (t) => t.id == id,
      orElse: () => _mockTransactions.first,
    );
    return tx.toEntity();
  }
}
