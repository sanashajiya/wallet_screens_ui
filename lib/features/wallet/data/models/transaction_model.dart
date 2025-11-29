// lib/features/wallet/data/models/transaction_model.dart
import '../../domain/entities/transaction_entity.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final double amount;
  final bool isIncome;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      date: date,
      amount: amount,
      isIncome: isIncome,
    );
  }
}
