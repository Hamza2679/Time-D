import 'package:flutter/material.dart';
import '../restaurant_detail/page/restaurant_detail_page.dart';

Widget buildRestaurants(BuildContext context, List<Map<String, dynamic>> restaurants) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      childAspectRatio: 3 / 4,
    ),
    itemCount: restaurants.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailPage(
                name: restaurants[index]["name"] ?? "Unknown",
                image: restaurants[index]["image"] ?? "default_image.png",
                address: restaurants[index]["address"] ?? "No address available",
                menu: restaurants[index]["menu"] ?? [],
              ),
            ),
          );
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  restaurants[index]["image"] ?? "default_image.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  restaurants[index]["name"] ?? "Unknown",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  restaurants[index]["address"] ?? "No address available",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

    },
  );
}