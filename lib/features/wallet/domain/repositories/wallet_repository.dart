import '../entities/wallet_overview_entity.dart';
import '../entities/payment_screen_entity.dart';
import '../entities/transaction_entity.dart';

abstract class WalletRepository {
  Future<WalletOverviewEntity> getWalletOverview();
  Future<PaymentScreenEntity> getPaymentScreenData();
  Future<List<TransactionEntity>> getTransactions();
  Future<TransactionEntity> getTransactionDetail(String id);
}
