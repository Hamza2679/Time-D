import 'package:equatable/equatable.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object?> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final Map<int, int> quantities;
  final double totalPrice;

  RestaurantLoaded(this.quantities, this.totalPrice);

  @override
  List<Object?> get props => [quantities, totalPrice];
}

class OrderSummary extends RestaurantState {
  final double totalPrice;

  OrderSummary(this.totalPrice);

  @override
  List<Object?> get props => [totalPrice];
}
