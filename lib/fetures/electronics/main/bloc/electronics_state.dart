import 'package:equatable/equatable.dart';

abstract class ElectronicsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ElectronicsInitial extends ElectronicsState {}

class ElectronicsLoading extends ElectronicsState {}

class ElectronicsLoaded extends ElectronicsState {
  final List<Map<String, dynamic>> stores;

  ElectronicsLoaded(this.stores);

  @override
  List<Object> get props => [stores];
}

class ElectronicsError extends ElectronicsState {
  final String message;

  ElectronicsError(this.message);

  @override
  List<Object> get props => [message];
}
