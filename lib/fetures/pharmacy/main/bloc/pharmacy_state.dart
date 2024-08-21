import 'package:equatable/equatable.dart';
import '../../../../models/pharmacy_model.dart';

abstract class PharmacyState extends Equatable {
  @override
  List<Object> get props => [];
}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final List<Pharmacy> pharmacies;

  PharmacyLoaded(this.pharmacies);

  @override
  List<Object> get props => [pharmacies];
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);

  @override
  List<Object> get props => [message];
}
