import 'package:delivery_app/fetures/notification/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/book_model.dart';
import '../../../models/electronics_model.dart';
import '../../../models/pharmacy_model.dart';
import '../../electronics/electronics_detail/pages/electronics_detail_page.dart';
import '../../food/main/pages/food_page.dart';
import '../../food/restaurant_detail/page/restaurant_detail_page.dart';
import '../../pharmacy/detail/page/pharmacy_detail_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../common/common.dart';
import '../../order/order_view.dart';
import '../../profile/pages/profile_view.dart';
import '../../common/data.dart';
import '../widgets/main_widget.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    FoodPage(),
    OrderView(),
    ProfileView(),
  ];

  // Example flag to indicate if there are unread notifications
  final bool hasUnreadNotifications = true; // Replace with actual logic

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainInitial) {
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
                  if (state.selectedIndex == 0) ...[
                    SizedBox(height: 12, width: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buildSearchBar(
                              height: 40,
                              onChanged: (query) {
                                BlocProvider.of<MainBloc>(context).add(SearchQueryChanged(query));
                              },
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => NotificationPage()),
                                  );
                                },
                              ),
                              if (hasUnreadNotifications)
                                Positioned(
                                  right: 8,
                                  top: 6,
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade900,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 15,
                                      minHeight: 15,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildCategories(context, categories, state.currentCategory),
                  ],
                  Expanded(
                    child: state.selectedIndex == 0
                        ? (state.filteredItems.isNotEmpty
                        ? buildSearchResults(state.currentCategory, state.filteredItems)
                        : buildCategoryPage(state.currentCategory))
                        : _widgetOptions.elementAt(state.selectedIndex),
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
                currentIndex: state.selectedIndex,
                selectedItemColor: Colors.deepOrange,
                onTap: (index) {
                  BlocProvider.of<MainBloc>(context).add(ItemTapped(index));
                },
              ),
            );
          }
          return Container(); // Return an empty container for other states, if any
        },
      ),
    );
  }

  Widget buildSearchResults(String category, List<dynamic> items) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailPage(
                  name: restaurants[index]["name"] ?? "Unknown",
                  image: restaurants[index]["image"] ?? "default_image.png",
                  address: restaurants[index]["address"] ?? "No address available",
                  menu: restaurants[index]["menu"] ?? [],
                ),));
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
              title: Text(item.name), // Access 'name' getter
              subtitle: Text(item.address),
              onTap: () {
                // Handle navigation to BookStore Detail Page
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
    // Add more categories as needed
      default:
        return SizedBox.shrink();
    }
  }
}
