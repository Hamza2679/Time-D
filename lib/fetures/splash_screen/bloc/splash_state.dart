import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashNavigate extends SplashState {
  final Widget nextScreen;

  SplashNavigate(this.nextScreen);

  @override
  List<Object> get props => [nextScreen];
}
