import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_wallet_overview.dart';
import 'wallet_overview_event.dart';
import 'wallet_overview_state.dart';

class WalletOverviewBloc
    extends Bloc<WalletOverviewEvent, WalletOverviewState> {
  final GetWalletOverview getWalletOverview;

  WalletOverviewBloc({
    required this.getWalletOverview,
  }) : super(const WalletOverviewInitial()) {
    on<WalletOverviewStarted>(_onStarted);
    on<WalletOverviewRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    WalletOverviewStarted event,
    Emitter<WalletOverviewState> emit,
  ) async {
    await _loadData(emit);
  }

  Future<void> _onRefreshRequested(
    WalletOverviewRefreshRequested event,
    Emitter<WalletOverviewState> emit,
  ) async {
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<WalletOverviewState> emit) async {
    emit(const WalletOverviewLoading());
    try {
      final overview = await getWalletOverview();
      emit(WalletOverviewLoaded(overview));
    } catch (e) {
      emit(const WalletOverviewError('Something went wrong. Please try again.'));
    }
  }
}
