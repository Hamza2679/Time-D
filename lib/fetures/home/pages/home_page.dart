import 'package:flutter/material.dart';
import '../../common/common.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  List<Map<String, String>> specialOffers = [
    {"image": "assets/offer1.jpg", "text": "50% off on Pizza"},
    {"image": "assets/offer2.jpg", "text": "Buy 1 Get 1 Free"},
    {"image": "assets/offer3.jpg", "text": "20% off on Electronics"},
    {"image": "assets/offer4.jpg", "text": "Free Delivery on Orders over \$50"},
  ];

  List<Map<String, dynamic>> restaurants = [
    {
      "image": "assets/restaurant1.jpg",
      "name": "Pizza Palace",
      "address": "123 Main St",
      "menu": [
        {"image": "assets/pizza.jpg", "name": "Margherita Pizza", "price": "\$8.99"},
        {"image": "assets/pizza.jpg", "name": "Pepperoni Pizza", "price": "\$9.99"},
      ],
    },
    {
      "image": "assets/restaurant2.jpg",
      "name": "Burger Haven",
      "address": "456 Oak St",
      "menu": [
        {"image": "assets/burger.jpg", "name": "Cheeseburger", "price": "\$5.99"},
        {"image": "assets/burger.jpg", "name": "Double Burger", "price": "\$7.99"},
      ],
    },
    {
      "image": "assets/restaurant3.jpg",
      "name": "Sushi World",
      "address": "789 Pine St",
      "menu": [
        {"image": "assets/sushi.jpg", "name": "California Roll", "price": "\$6.99"},
        {"image": "assets/sushi.jpg", "name": "Spicy Tuna Roll", "price": "\$7.99"},
      ],
    },
    {
      "image": "assets/restaurant4.jpg",
      "name": "Taco Town",
      "address": "101 Maple St",
      "menu": [
        {"image": "assets/taco.jpg", "name": "Chicken Taco", "price": "\$2.99"},
        {"image": "assets/taco.jpg", "name": "Beef Taco", "price": "\$3.99"},
      ],
    },
  ];

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
      appBar: AppBar(
        title: Text('Delivery App'),
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
                'Special Offers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              buildSpecialOffers(specialOffers),
              SizedBox(height: 16),
              Text(
                'Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              buildRestaurants(context, _filteredRestaurants()),
            ],
          ),
        ),
      ),
    );
  }
}
