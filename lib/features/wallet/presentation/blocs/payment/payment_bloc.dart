// lib/features/wallet/presentation/blocs/payment/payment_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_payment_screen.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentScreen getPaymentScreen;

  PaymentBloc({required this.getPaymentScreen})
      : super(const PaymentLoading()) {
    on<PaymentStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PaymentStarted event,
    Emitter<PaymentState> emit,
  ) async {
    emit(const PaymentLoading());
    try {
      final data = await getPaymentScreen();
      emit(PaymentLoaded(data));
    } catch (_) {
      emit(const PaymentError('Unable to load payment data.'));
    }
  }
}
