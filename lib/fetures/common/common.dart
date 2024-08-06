import 'package:flutter/material.dart';
import '../books/books_page.dart';
import '../electronics/electronics_page.dart';
import '../gift/gift_page.dart';
import '../home/pages/main_page.dart';
import '../home/pages/restaurant_detail_page.dart';
import '../pharmacy/pharmacy_page.dart';
import '../sparepart/sparepart_page.dart';

Widget buildHeader(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildSearchBar({double height = 56.0, required ValueChanged<String> onChanged}) {
  return Container(

    height: height,
    child: TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for items',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}



Widget buildCategories(BuildContext context, List<Map<String, dynamic>> categories) {
  return Container(
    height: 160,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // Navigate based on the category
            if (category["text"] == "Food") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            } else if (category["text"] == "Electronics") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ElectronicsPage()),
              );
            } else if (category["text"] == "Pharmacy") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PharmacyPage()),
              );
            } else if (category["text"] == "Spare part") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SparePartPage()),
              );
            } else if (category["text"] == "Gifts") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GiftPage()),
              );
            } else if (category["text"] == "Books and Stationery") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BooksPage()),
              );
            }
          },
          child: Container(
            margin: EdgeInsets.only(right: 16),
            width: 100,
            child: Column(
              children: [
                Image.asset(category["image"], height: 100, fit: BoxFit.cover),
                SizedBox(height: 8),
                Text(
                  category["text"],
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
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
                name: restaurants[index]["name"],
                image: restaurants[index]["image"],
                address: restaurants[index]["address"],
                menu: restaurants[index]["menu"],
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
                  restaurants[index]["image"]!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  restaurants[index]["name"]!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  restaurants[index]["address"]!,
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
