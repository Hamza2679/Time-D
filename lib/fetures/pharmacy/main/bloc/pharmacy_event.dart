import 'package:equatable/equatable.dart';

abstract class PharmacyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPharmacies extends PharmacyEvent {}
