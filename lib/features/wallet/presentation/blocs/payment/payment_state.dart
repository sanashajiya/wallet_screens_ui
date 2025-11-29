// lib/features/wallet/presentation/blocs/payment/payment_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/payment_screen_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentLoaded extends PaymentState {
  final PaymentScreenEntity data;

  const PaymentLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
