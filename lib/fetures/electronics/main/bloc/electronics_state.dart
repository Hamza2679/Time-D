// electronics_state.dart

import 'package:equatable/equatable.dart';

abstract class ElectronicsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ElectronicsInitial extends ElectronicsState {}

class ElectronicsLoaded extends ElectronicsState {
  final List<String> electronics;

  ElectronicsLoaded(this.electronics);

  @override
  List<Object?> get props => [electronics];
}

class ElectronicsError extends ElectronicsState {
  final String message;

  ElectronicsError(this.message);

  @override
  List<Object?> get props => [message];
}
