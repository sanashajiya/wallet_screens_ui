class TransactionEntity {
  final String id;
  final String title;      // e.g. "Starbucks"
  final String subtitle;   // e.g. "Coffee break"
  final DateTime date;
  final double amount;
  final bool isIncome;     // true = +, false = -

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isIncome,
  });
}
