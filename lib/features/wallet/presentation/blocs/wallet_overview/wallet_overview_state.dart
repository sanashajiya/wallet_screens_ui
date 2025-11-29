// lib/features/wallet/presentation/blocs/wallet_overview/wallet_overview_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/wallet_overview_entity.dart';

abstract class WalletOverviewState extends Equatable {
  const WalletOverviewState();

  @override
  List<Object?> get props => [];
}

class WalletOverviewInitial extends WalletOverviewState {
  const WalletOverviewInitial();
}

class WalletOverviewLoading extends WalletOverviewState {
  const WalletOverviewLoading();
}

class WalletOverviewLoaded extends WalletOverviewState {
  final WalletOverviewEntity data;

  const WalletOverviewLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class WalletOverviewError extends WalletOverviewState {
  final String message;

  const WalletOverviewError(this.message);

  @override
  List<Object?> get props => [message];
}
