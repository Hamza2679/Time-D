import 'package:flutter/material.dart';
import '../../common/common.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> specialOffers = [
      {"image": "assets/offer1.jpg", "text": "50% off on Pizza"},
      {"image": "assets/offer2.jpg", "text": "Buy 1 Get 1 Free"},
      {"image": "assets/offer3.jpg", "text": "20% off on Electronics"},
      {"image": "assets/offer4.jpg", "text": "Free Delivery on Orders over \$50"},
      {"image": "assets/offer1.jpg", "text": "50% off on Pizza"},
      {"image": "assets/offer2.jpg", "text": "Buy 1 Get 1 Free"},
      {"image": "assets/offer3.jpg", "text": "20% off on Electronics"},
      {"image": "assets/offer4.jpg", "text": "Free Delivery on Orders over \$50"},
    ];

    List<Map<String, String>> restaurants = [
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
      {"image": "assets/restaurant1.jpg", "name": "Pizza Palace", "address": "123 Main St"},
      {"image": "assets/restaurant2.jpg", "name": "Burger Haven", "address": "456 Oak St"},
      {"image": "assets/restaurant3.jpg", "name": "Sushi World", "address": "789 Pine St"},
      {"image": "assets/restaurant4.jpg", "name": "Taco Town", "address": "101 Maple St"},
    ];

    return Scaffold(
      appBar: PreferredSize(
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
             // buildHeader('Welcome to Delivery App'),
              SizedBox(height: 8),
              buildSearchBar(height: 40),
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
              buildRestaurants(restaurants),
            ],
          ),
        ),
      ),
    );
  }
}
