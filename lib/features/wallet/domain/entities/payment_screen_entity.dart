import 'transaction_entity.dart';

class PaymentScreenEntity {
  final String cardHolderName;
  final String cardNumberMasked; // e.g. "**** **** **** 1234"
  final String expiry;           // e.g. "12/26"
  final double cardBalance;

  final double income;
  final double expense;

  final List<TransactionEntity> history;

  const PaymentScreenEntity({
    required this.cardHolderName,
    required this.cardNumberMasked,
    required this.expiry,
    required this.cardBalance,
    required this.income,
    required this.expense,
    required this.history,
  });
}
