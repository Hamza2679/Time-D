// otp_state.dart
import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpVerifying extends OtpState {}

class OtpVerified extends OtpState {}

class OtpFailed extends OtpState {
  final String error;

  const OtpFailed(this.error);

  @override
  List<Object> get props => [error];
}
