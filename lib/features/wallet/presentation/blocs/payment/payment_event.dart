// lib/features/wallet/presentation/blocs/payment/payment_event.dart
import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class PaymentStarted extends PaymentEvent {
  const PaymentStarted();
}
