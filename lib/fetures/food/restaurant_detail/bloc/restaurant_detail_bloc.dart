import 'package:flutter_bloc/flutter_bloc.dart';
import 'restaurant_detail_event.dart';
import 'restaurant_detail_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final List<Map<String, String>> menu;
  Map<int, int> quantities = {};
  double _totalPrice = 0.0;

  RestaurantBloc(this.menu) : super(RestaurantInitial()) {
    on<LoadMenu>((event, emit) {
      for (int i = 0; i < menu.length; i++) {
        quantities[i] = 0;
      }
      emit(RestaurantLoaded(quantities, _totalPrice));
    });

    on<IncrementQuantity>((event, emit) {
      quantities[event.index] = quantities[event.index]! + 1;
      _updateTotalPrice();
      emit(RestaurantLoaded(quantities, _totalPrice));
    });

    on<DecrementQuantity>((event, emit) {
      if (quantities[event.index]! > 0) {
        quantities[event.index] = quantities[event.index]! - 1;
        _updateTotalPrice();
      }
      emit(RestaurantLoaded(quantities, _totalPrice));
    });

    on<BuyNow>((event, emit) {
      emit(OrderSummary(_totalPrice));
      for (int i = 0; i < menu.length; i++) {
        quantities[i] = 0;
      }
      _updateTotalPrice();
    });
  }

  void _updateTotalPrice() {
    _totalPrice = 0.0;
    quantities.forEach((index, quantity) {
      double price = double.parse(menu[index]["price"]!.substring(1));
      _totalPrice += price * quantity;
    });
  }
}
