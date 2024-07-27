import 'package:flutter/material.dart';
import 'home_page.dart';
import '../../order/order_view.dart';
import '../../profile/profile_view.dart';

// This is the main page that contains the bottom navigation bar and handles navigation between different views.
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Keeps track of the currently selected tab index

  // List of widgets for each tab. Each widget corresponds to a different page.
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    OrderView(),
    ProfileView(),
  ];

  // Handles the logic for when a tab is tapped. Updates the selected index and refreshes the UI.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex), // Displays the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for Home tab
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt), // Icon for Orders tab
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Icon for Profile tab
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // The currently selected tab
        selectedItemColor: Colors.deepOrange, // Color of the selected tab icon
        onTap: _onItemTapped, // Callback for when a tab is tapped
      ),
    );
  }
}
