import 'package:delivery_app/fetures/notification/notification_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/category_data.dart';
import '../../food/main/pages/food_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../order/order_view.dart';
import '../../profile/pages/profile_view.dart';
import '../widgets/main_widget.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    FoodPage(),
    OrderView(),
    ProfileView(),
  ];

  final bool hasUnreadNotifications = true;

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
                  backgroundColor: primaryColor,
                ),
              ),
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search Bar and Notifications
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
                                          MaterialPageRoute(
                                              builder: (context) => NotificationPage()),
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
                                            color: redColor,
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

                          SizedBox(height: 12),

                          // Advertisement Cards (Scrollable horizontally)
                          Container(
                            height: 150, // Set a fixed height for the ads
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4, // 4 advertisement cards
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Card(
                                    color: Color(0xFF780C23), // Background color
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      width: 250, // Width of each card
                                      child: Center(
                                        child: Text(
                                          'Ad ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 12),

                          // Categories
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.category,
                                  color: secondaryTextColor,
                                  size: 14,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 7),
                          buildCategories(context, categories, state.currentCategory),
                        ],
                      ),
                    ),
                  ];
                },
                body: state.selectedIndex == 0
                    ? (state.filteredItems.isNotEmpty
                    ? buildSearchResults(
                    state.currentCategory, state.filteredItems)
                    : buildCategoryPage(state.currentCategory))
                    : _widgetOptions.elementAt(state.selectedIndex),
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
                selectedItemColor: primaryColor,
                onTap: (index) {
                  BlocProvider.of<MainBloc>(context).add(ItemTapped(index));
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
