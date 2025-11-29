import 'package:equatable/equatable.dart';

abstract class TransactionDetailEvent extends Equatable {
  const TransactionDetailEvent();

  @override
  List<Object?> get props => [];
}

class TransactionDetailStarted extends TransactionDetailEvent {
  final String transactionId;

  const TransactionDetailStarted(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}
