import 'package:flutter/material.dart';
import '../common/common.dart';
import 'restaurant_detail_page.dart';
import '../common/data.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              buildRestaurants(context, _filteredRestaurants()),
            ],
          ),
        ),
      ),
    );
  }
}
