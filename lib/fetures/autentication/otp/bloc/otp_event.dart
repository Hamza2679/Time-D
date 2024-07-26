// otp_event.dart
import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpChanged extends OtpEvent {
  final String otp;

  const OtpChanged(this.otp);

  @override
  List<Object> get props => [otp];
}

class VerifyOtp extends OtpEvent {
  final String verificationId;
  final String otp;

  const VerifyOtp(this.verificationId, this.otp);

  @override
  List<Object> get props => [verificationId, otp];
}

class ResendOtp extends OtpEvent {}
