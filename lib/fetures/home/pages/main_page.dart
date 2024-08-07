import 'package:flutter/material.dart';
import '../../books/books_page.dart';
import '../../common/common.dart';
import '../../electronics/electronics_page.dart';
import '../../food/food_page.dart';
import '../../gift/gift_page.dart';
import '../../pharmacy/pharmacy_page.dart';
import '../../sparepart/sparepart_page.dart';
import '../../order/order_view.dart';
import '../../profile/profile_view.dart';
import '../../common/data.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _currentCategory = 'Food'; // Default category

  static List<Widget> _widgetOptions = <Widget>[
    FoodPage(),
    OrderView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 0) {
        // Clear search query when navigating away from HomePage
        _searchQuery = '';
      }
    });
  }

  void _onCategoryTapped(String route) {
    setState(() {
      switch (route) {
        case '/electronics':
          _currentCategory = 'Electronics';
          break;
        case '/food':
          _currentCategory = 'Food';
          break;
        case '/pharmacy':
          _currentCategory = 'Pharmacy';
          break;
        case '/sparepart':
          _currentCategory = 'SparePart';
          break;
        case '/gift':
          _currentCategory = 'Gifts';
          break;
        case '/books_and_stationery':
          _currentCategory = 'Books';
          break;
        default:
          _currentCategory = 'Food';
      }
    });
  }

  Widget _buildCategoryPage() {
    switch (_currentCategory) {
      case 'Food':
        return FoodPage();
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
      default:
        return FoodPage();
    }
  }

  Widget buildCategories(BuildContext context, List<Map<String, dynamic>> categories) {
    return Container(
      height: 126,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          bool isSelected = _currentCategory == category['text'];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                _onCategoryTapped(category['route']);
              },
              child: Container(
                width: 130,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepOrange : Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      category['image'],
                      width: 130,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      category['text'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedIndex == 0) ...[
            SizedBox(height: 12, width: 5),
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
          ],
          Expanded(
            child: _selectedIndex == 0
                ? _buildCategoryPage() // Display the selected category page
                : _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}
