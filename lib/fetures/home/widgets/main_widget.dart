import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:delivery_app/fetures/home/pages/discover_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../organization/organization_page.dart';
Widget buildCategoryPage(String currentCategory) {
  switch (currentCategory) {

    default:
      return DiscoverPage();
  }
}


Future<List<Map<String, dynamic>>> fetchOrganizations(String categoryId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  final response = await http.get(
    Uri.parse('https://hello-delivery.onrender.com/api/v1/category/$categoryId'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> organizations = data['organizations'];

    if (organizations != null && organizations.isNotEmpty) {
      return organizations.map((organization) {
        List<Map<String, dynamic>> products = (organization['ProductOrganization'] as List<dynamic>).map((productOrg) {
          final product = productOrg['product'];
          return {
            'productId': product['id'],
            'name': product['name'],
            'price': product['price'],
            'description': product['description'],
            'image': product['image'],
            'paymentCategory': product['paymentCategory'],
            'initialDeliveryFee': product['InitialdeliveryFee'],
          };
        }).toList();

        return {
          'id': organization['id'],
          'name': organization['name'],
          'location': organization['address'],
          'rating': organization['rating'],
          'image': organization['image'],
          'email': organization['email'],
          'phone': organization['phone'],
          'products': products,
        };
      }).toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load organizations');
  }
}




Future<List<Map<String, dynamic>>> fetchCategories() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');

  if (accessToken == null) {
    throw Exception('No access token found');
  }

  final headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  final response = await http.get(
    Uri.parse('https://hello-delivery.onrender.com/api/v1/category'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    List<Map<String, dynamic>> categoriesFromBackend = data.map((category) {
      return {
        'id': category['id'],
        'image': category['image'],
        'text': category['name'],
        'route': '/${category['name'].toLowerCase().replaceAll(' ', '_')}'
      };
    }).toList();

    categoriesFromBackend.insert(0, {
      "id": "all",
      "image": "assets/All_category.png",
      "text": "All",
      "route": "/discover"
    });

    return categoriesFromBackend;
  } else {
    throw Exception('Failed to load categories');
  }
}



Widget buildCategories(BuildContext context, String currentCategory) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: fetchCategories(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error loading categories'));
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
                    onTap: () async {
                      String categoryId = category['id'];

                      try {
                        List<Map<String, dynamic>> organizations = await fetchOrganizations(categoryId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrganizationPage(organizations: organizations),
                          ),
                        );
                      } catch (error) {
                        print('Error fetching organizations: $error');
                      }
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
                          child: category['id'] == "all"
                              ? Image.asset(
                            category['image'],
                            width: 80,
                            height: 48,
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            category['image'],
                            width: 80,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(height: 2),
                        Text(
                          category['text'],
                          style: TextStyle(
                            color: isSelected ? primaryTextColor : secondaryTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
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