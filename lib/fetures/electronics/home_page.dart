import 'package:flutter/material.dart';
import '../common/common.dart';
import '../home/pages/restaurant_detail_page.dart';
import '../common/data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
    return Scaffold(appBar: PreferredSize(
      preferredSize: Size.fromHeight(5.0),
      child: AppBar(
        // title: Text('Hello Delivery',style: TextStyle(fontSize: 5),),
      ),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBar(
                height: 40,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              buildCategories(context, categories),
              SizedBox(height: 16),
              Text(
                'Electronics stores ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
