import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpVerifying extends OtpState {}

class OtpVerified extends OtpState {}

class OtpVerificationFailed extends OtpState {
  final String error;

  const OtpVerificationFailed(this.error);

  @override
  List<Object> get props => [error];
}

class OtpResent extends OtpState {
  final String verificationId;

  const OtpResent(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}
