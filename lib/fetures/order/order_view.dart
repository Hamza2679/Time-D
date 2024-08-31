import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/order_model.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  Map<String, List<OrderItem>> groupedOrders = {};

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final loadedOrders = await loadOrders();
    setState(() {
      groupedOrders = groupOrdersByRestaurant(loadedOrders);
    });
  }

  Future<List<OrderItem>> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? orderJsonList = prefs.getStringList('orderItems');
    if (orderJsonList != null) {
      return orderJsonList.map((json) => OrderItem.fromJson(jsonDecode(json))).toList();
    }
    return [];
  }

  Map<String, List<OrderItem>> groupOrdersByRestaurant(List<OrderItem> orders) {
    Map<String, List<OrderItem>> grouped = {};
    for (var item in orders) {
      if (!grouped.containsKey(item.restaurantName)) {
        grouped[item.restaurantName] = [];
      }
      grouped[item.restaurantName]!.add(item);
    }
    return grouped;
  }

  Future<void> removeOrder(String restaurantName) async {
    groupedOrders.remove(restaurantName);
    setState(() {});

    final prefs = await SharedPreferences.getInstance();
    List<OrderItem> remainingOrders = [];
    groupedOrders.values.forEach((orderList) {
      remainingOrders.addAll(orderList);
    });
    List<String> orderJsonList = remainingOrders.map((order) => jsonEncode(order.toJson())).toList();
    await prefs.setStringList('orderItems', orderJsonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: groupedOrders.isEmpty
          ? Center(
        child: Text(
          'No items in your order.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: groupedOrders.entries.map((entry) {
            final restaurantName = entry.key;
            final items = entry.value;

            return Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.itemName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            'Qty: ${item.quantity}  ,  ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          removeOrder(restaurantName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('cancel' , style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
