import 'package:flutter/material.dart';

class CartItem {
  final String restaurantName;
  final String itemName;
  final double price;
  int quantity;

  CartItem({
    required this.restaurantName,
    required this.itemName,
    required this.price,
    this.quantity = 0,
  });
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere(
          (i) => i.restaurantName == item.restaurantName && i.itemName == item.itemName,
    );

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  double get totalPrice {
    return _items.fold(0.0, (total, item) => total + (item.price * item.quantity));
  }
}

class CartProvider with ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(CartItem item) {
    _cart.addItem(item);
    notifyListeners();
  }

  double get totalPrice => _cart.totalPrice;
}
