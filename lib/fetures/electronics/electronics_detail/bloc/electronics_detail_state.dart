import 'package:flutter/foundation.dart';

@immutable
abstract class ElectronicsDetailState {}

class ElectronicsDetailInitial extends ElectronicsDetailState {
  final Map<String, int> quantities;
  final double totalPrice;

  ElectronicsDetailInitial(this.quantities, this.totalPrice);
}
