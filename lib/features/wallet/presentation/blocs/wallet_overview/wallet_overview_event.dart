// lib/features/wallet/presentation/blocs/wallet_overview/wallet_overview_event.dart
import 'package:equatable/equatable.dart';

abstract class WalletOverviewEvent extends Equatable {
  const WalletOverviewEvent();

  @override
  List<Object?> get props => [];
}

class WalletOverviewStarted extends WalletOverviewEvent {
  const WalletOverviewStarted();
}

class WalletOverviewRefreshRequested extends WalletOverviewEvent {
  const WalletOverviewRefreshRequested();
}
