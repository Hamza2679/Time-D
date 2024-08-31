import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/order_model.dart';
import 'restaurant_detail_event.dart';
import 'restaurant_detail_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<void> saveOrders(List<OrderItem> newOrderItems) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> orderJsonList = prefs.getStringList('orderItems') ?? [];
  List<OrderItem> existingOrders = orderJsonList.map((json) => OrderItem.fromJson(jsonDecode(json))).toList();
  Map<String, List<OrderItem>> groupedOrders = {};
  for (var item in existingOrders) {
    if (!groupedOrders.containsKey(item.restaurantName)) {
      groupedOrders[item.restaurantName] = [];
    }
    groupedOrders[item.restaurantName]!.add(item);
  }
  for (var item in newOrderItems) {
    if (!groupedOrders.containsKey(item.restaurantName)) {
      groupedOrders[item.restaurantName] = [];
    }
    groupedOrders[item.restaurantName]!.add(item);
  }
  List<OrderItem> allOrders = [];
  groupedOrders.forEach((restaurant, items) {
    allOrders.addAll(items);
  });
  orderJsonList = allOrders.map((item) => jsonEncode(item.toJson())).toList();
  prefs.setStringList('orderItems', orderJsonList);
}
