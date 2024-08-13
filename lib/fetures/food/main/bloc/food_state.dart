import 'package:equatable/equatable.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object?> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Map<String, dynamic>> filteredRestaurants;

  const FoodLoaded(this.filteredRestaurants);

  @override
  List<Object?> get props => [filteredRestaurants];
}
