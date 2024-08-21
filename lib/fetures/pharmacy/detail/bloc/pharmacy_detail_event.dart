import 'package:equatable/equatable.dart';

import '../../../../models/pharmacy_model.dart';

abstract class PharmacyDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class LoadPharmacyDetails extends PharmacyDetailEvent {
  final Pharmacy pharmacy;
  final List<Drug> drugs;  // Add this field

  LoadPharmacyDetails(this.pharmacy, this.drugs);  // Update constructor

  @override
  List<Object> get props => [pharmacy, drugs];  // Add drugs to props
}
