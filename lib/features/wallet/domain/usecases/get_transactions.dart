// lib/features/wallet/domain/usecases/get_transactions.dart
import '../entities/transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetTransactions {
  final WalletRepository repository;

  GetTransactions(this.repository);

  Future<List<TransactionEntity>> call() {
    return repository.getTransactions();
  }
}
