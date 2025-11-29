// lib/features/wallet/domain/usecases/get_transaction_detail.dart
import '../entities/transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetTransactionDetail {
  final WalletRepository repository;

  GetTransactionDetail(this.repository);

  Future<TransactionEntity> call(String id) {
    return repository.getTransactionDetail(id);
  }
}
