import 'package:delivery_app/fetures/food/widgets/food_widgets.dart';
import 'package:flutter/material.dart';

import '../../common/data.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPage createState() => _FoodPage();
}

class _FoodPage extends State<FoodPage> {
  String _searchQuery = '';

  List<Map<String, dynamic>> _filteredRestaurants() {
    if (_searchQuery.isEmpty) {
      return restaurants;
    }
    return restaurants.where((restaurant) {
      bool matchesRestaurantName = restaurant["name"]!.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesMenuItems = restaurant["menu"]!.any((item) {
        return item["name"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item["price"]!.contains(_searchQuery);
      });
      return matchesRestaurantName || matchesMenuItems;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          //backgroundColor: Colors.deepOrange,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white54,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Restaurants',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    buildRestaurants(context, _filteredRestaurants()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
