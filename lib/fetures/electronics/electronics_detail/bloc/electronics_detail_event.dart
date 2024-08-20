import 'package:flutter/foundation.dart';

@immutable
abstract class ElectronicsDetailEvent {}

class UpdateQuantityEvent extends ElectronicsDetailEvent {
  final String itemName;
  final int change;

  UpdateQuantityEvent(this.itemName, this.change);
}
