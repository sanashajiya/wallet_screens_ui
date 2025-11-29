import 'package:equatable/equatable.dart';
import '../../../domain/entities/transaction_entity.dart';

abstract class TransactionDetailState extends Equatable {
  const TransactionDetailState();

  @override
  List<Object?> get props => [];
}

class TransactionDetailLoading extends TransactionDetailState {
  const TransactionDetailLoading();
}

class TransactionDetailLoaded extends TransactionDetailState {
  final TransactionEntity transaction;

  const TransactionDetailLoaded(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class TransactionDetailError extends TransactionDetailState {
  final String message;

  const TransactionDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
