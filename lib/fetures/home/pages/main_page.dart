import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../food/pages/food_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../common/common.dart';
import '../../order/order_view.dart';
import '../../profile/profile_view.dart';
import '../../common/data.dart';
import '../widgets/main_widget.dart';

class MainPage extends StatelessWidget {
  static List<Widget> _widgetOptions = <Widget>[
    FoodPage(),
    OrderView(),
    ProfileView(),
  ];



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
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                              // Handle notification button tap here
                              print("Notification button tapped");
                            },
                          ),
                        ],
                      ),
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
                    buildCategories(context, categories, state.currentCategory),
                  ],
                  Expanded(
                    child: state.selectedIndex == 0
                        ? buildCategoryPage(state.currentCategory)
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
}
