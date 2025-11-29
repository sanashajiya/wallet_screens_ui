import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_transaction_detail.dart';
import 'transaction_detail_event.dart';
import 'transaction_detail_state.dart';

class TransactionDetailBloc
    extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  final GetTransactionDetail getTransactionDetail;

  TransactionDetailBloc({required this.getTransactionDetail})
      : super(const TransactionDetailLoading()) {
    on<TransactionDetailStarted>(_onStarted);
  }

  Future<void> _onStarted(
    TransactionDetailStarted event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(const TransactionDetailLoading());
    try {
      final tx = await getTransactionDetail(event.transactionId);
      emit(TransactionDetailLoaded(tx));
    } catch (_) {
      emit(const TransactionDetailError('Unable to load transaction.'));
    }
  }
}
