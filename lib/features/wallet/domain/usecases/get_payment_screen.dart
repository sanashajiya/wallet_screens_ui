// lib/features/wallet/domain/usecases/get_payment_screen.dart
import '../entities/payment_screen_entity.dart';
import '../repositories/wallet_repository.dart';

class GetPaymentScreen {
  final WalletRepository repository;

  GetPaymentScreen(this.repository);

  Future<PaymentScreenEntity> call() {
    return repository.getPaymentScreenData();
  }
}
