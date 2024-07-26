import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // Add this import

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class PhoneNumberChanged extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class CountryCodeChanged extends LoginEvent {
  final String countryCode;

  const CountryCodeChanged(this.countryCode);

  @override
  List<Object?> get props => [countryCode];
}

class SubmitPhoneNumber extends LoginEvent {
  final BuildContext context; // Pass context to navigate

  const SubmitPhoneNumber(this.context);

  @override
  List<Object?> get props => [context];
}
