// lib/features/wallet/domain/usecases/get_wallet_overview.dart
import '../entities/wallet_overview_entity.dart';
import '../repositories/wallet_repository.dart';

class GetWalletOverview {
  final WalletRepository repository;

  GetWalletOverview(this.repository);

  Future<WalletOverviewEntity> call() {
    return repository.getWalletOverview();
  }
}
