// splash_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class NextScreenEvent extends SplashEvent {
  final Widget nextScreen;

  const NextScreenEvent(this.nextScreen);

  @override
  List<Object> get props => [nextScreen];
}
