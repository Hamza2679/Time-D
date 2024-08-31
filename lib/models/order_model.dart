class OrderItem {
  final String restaurantName;
  final String itemName;
  final int quantity;
  final double price;

  OrderItem({
    required this.restaurantName,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurantName': restaurantName,
      'itemName': itemName,
      'quantity': quantity,
      'price': price,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem(
      restaurantName: json['restaurantName'],
      itemName: json['itemName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
