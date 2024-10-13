import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../restaurant_detail/page/restaurant_detail_page.dart';


Widget buildRestaurants(BuildContext context, List<Map<String, dynamic>> restaurants) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,  // Slightly larger space for aesthetics
      mainAxisSpacing: 12.0,
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
          elevation: 6, // Adds shadow for a floating effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),  // Rounded corners
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16), // Ensures rounded corners for the image
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orangeAccent, Colors.deepOrange],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Image.asset(
                          restaurants[index]["image"] ?? "default_image.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        restaurants[index]["name"] ?? "Unknown",
                        style: TextStyle(
                          fontSize: 18,  // Larger font size for title
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      child: Text(
                        restaurants[index]["address"] ?? "No address available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      );
    },
  );
}


Widget buildQuantityButton({required IconData icon, required Color color, required double size, required VoidCallback onPressed}) {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      iconSize: 32,
      icon: Icon(icon, color: primaryTextColor),
      onPressed: onPressed,
    ),
  );
}

