import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenu extends RestaurantEvent {}

class IncrementQuantity extends RestaurantEvent {
  final int index;

  IncrementQuantity(this.index);

  @override
  List<Object?> get props => [index];
}

class DecrementQuantity extends RestaurantEvent {
  final int index;

  DecrementQuantity(this.index);

  @override
  List<Object?> get props => [index];
}

class BuyNow extends RestaurantEvent {}
