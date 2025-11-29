import '../entities/transaction_entity.dart';
import '../repositories/wallet_repository.dart';

class GetTransactionDetail {
  final WalletRepository repository;

  GetTransactionDetail(this.repository);

  Future<TransactionEntity> call(String id) {
    return repository.getTransactionDetail(id);
  }
}
