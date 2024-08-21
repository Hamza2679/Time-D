// pharmacy_detail_state.dart
import 'package:equatable/equatable.dart';
import '../../../../models/pharmacy_model.dart';

abstract class PharmacyDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PharmacyDetailInitial extends PharmacyDetailState {}

class PharmacyDetailLoading extends PharmacyDetailState {}

class PharmacyDetailLoaded extends PharmacyDetailState {
  final List<Drug> drugs;

  PharmacyDetailLoaded(this.drugs);

  @override
  List<Object> get props => [drugs];
}

class PharmacyDetailError extends PharmacyDetailState {
  final String message;

  PharmacyDetailError(this.message);

  @override
  List<Object> get props => [message];
}
