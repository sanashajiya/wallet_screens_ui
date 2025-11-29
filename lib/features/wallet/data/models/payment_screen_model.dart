// lib/features/wallet/data/models/payment_screen_model.dart
import '../../domain/entities/payment_screen_entity.dart';
import '../../domain/entities/transaction_entity.dart';

class PaymentScreenModel {
  final String cardHolderName;
  final String cardNumberMasked;
  final String expiry;
  final double cardBalance;
  final double income;
  final double expense;
  final List<TransactionEntity> history;

  const PaymentScreenModel({
    required this.cardHolderName,
    required this.cardNumberMasked,
    required this.expiry,
    required this.cardBalance,
    required this.income,
    required this.expense,
    required this.history,
  });

  PaymentScreenEntity toEntity() {
    return PaymentScreenEntity(
      cardHolderName: cardHolderName,
      cardNumberMasked: cardNumberMasked,
      expiry: expiry,
      cardBalance: cardBalance,
      income: income,
      expense: expense,
      history: history,
    );
  }
}
