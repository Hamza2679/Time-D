import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/fetures/home/pages/discover_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import '../../../models/book_model.dart';
import '../../../models/electronics_model.dart';
import '../../../models/pharmacy_model.dart';
import '../../books/main/pages/books_page.dart';
import '../../electronics/electronics_detail/pages/electronics_detail_page.dart';
import '../../electronics/main/pages/electronics_page.dart';
import '../../food/main/pages/food_page.dart';
import '../../food/restaurant_detail/page/restaurant_detail_page.dart';
import '../../gift/gift_page.dart';
import '../../pharmacy/detail/page/pharmacy_detail_page.dart';
import '../../pharmacy/main/page/pharmacy_page.dart';
import '../../sparepart/sparepart_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

Widget buildCategoryPage(String currentCategory) {
  switch (currentCategory) {
    case 'Electronics':
      return ElectronicsPage();
    case 'Pharmacy':
      return PharmacyPage();
    case 'SparePart':
      return SparePartPage();
    case 'Gifts':
      return GiftsPage();
    case 'Books':
      return BooksPage();
    case 'Food':
      return FoodPage();
    default:
      return DiscoverPage();
  }
}

Future<List<Map<String, dynamic>>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://hello-delivery.onrender.com/api/v1/category'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    List<Map<String, dynamic>> categoriesFromBackend = data.map((category) {
      return {
        'image': category['image'],
        'text': category['name'],
        'route': '/${category['name'].toLowerCase().replaceAll(' ', '_')}' // Generate route based on category name
      };
    }).toList();

    // Prepend the 'All' category
    categoriesFromBackend.insert(0, {"image": "assets/All_category.png", "text": "All", "route": "/discover"});

    return categoriesFromBackend;
  } else {
    throw Exception('Failed to load categories');
  }
}


Widget buildCategories(BuildContext context, String currentCategory) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchCategories(), // Call the function to fetch categories
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching
      } else if (snapshot.hasError) {
        return Center(child: Text('Error loading categories')); // Error handling
      } else if (snapshot.hasData) {
        List<Map<String, dynamic>> categories = snapshot.data!;

        return Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              bool isSelected = currentCategory == category['text'];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<MainBloc>(context).add(CategoryTapped(category['route']));
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isSelected ? [primaryColor, secondaryColor] : [primaryTextColor, greyColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            category['image'],
                            width: 80,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          category['text'],
                          style: TextStyle(
                            color: isSelected ? primaryTextColor : secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
      return Container(); // Handle an empty state
    },
  );
}


Widget buildSearchResults(String category, List<dynamic> items) {
  print("Search results called with category: $category and items length: ${items.length}"); // Debug print

  if (items.isEmpty) {
    print("No data found");
    return Center(
      child: Text(
        'No data found',
        style: TextStyle(fontSize: 18, color: greyColor),
      ),
    );
  }

  switch (category) {
    case 'Food':
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index] as Map<String, dynamic>;
          return ListTile(
            leading: Image.asset(item['image']),
            title: Text(item['name']),
            subtitle: Text(item['address']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantDetailPage(
                    name: item["name"] ?? "Unknown",
                    image: item["image"] ?? "default_image.png",
                    address: item["address"] ?? "No address available",
                    menu: item["menu"] ?? [],
                  ),
                ),
              );
            },
          );
        },
      );
    case 'Pharmacy':
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index] as Pharmacy;
          return ListTile(
            leading: Image.asset(item.image),
            title: Text(item.name),
            subtitle: Text(item.address),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PharmacyDetailPage(
                    pharmacy: item,
                  ),
                ),
              );
            },
          );
        },
      );
    case 'Books':
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index] as BookStore;
          return ListTile(
            leading: Icon(Icons.book),
            title: Text(item.name),
            subtitle: Text(item.address),
            onTap: () {

            },
          );
        },
      );
    case 'Electronics':
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index] as ElectronicsStore;
          return ListTile(
            leading: Image.asset(item.image),
            title: Text(item.name),
            subtitle: Text(item.location),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElectronicsDetailPage(store: item),
                ),
              );
            },
          );
        },
      );
    default:
      return SizedBox.shrink();
  }
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