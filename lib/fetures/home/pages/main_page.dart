import 'package:delivery_app/fetures/notification/notification_page.dart';
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
                                BlocProvider.of<MainBloc>(context).add(
                                    SearchQueryChanged(query));
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
                                    MaterialPageRoute(builder: (context) =>
                                        NotificationPage()),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: Colors.black,
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: <Color>[Colors.black, Colors.black],
                                ).createShader(
                                    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 7),
                    buildCategories(context, categories, state.currentCategory),
                  ],

                  Expanded(
                    child: state.selectedIndex == 0
                        ? (state.filteredItems.isNotEmpty
                        ? buildSearchResults(
                        state.currentCategory, state.filteredItems)
                        : buildCategoryPage(state.currentCategory))
                        : _widgetOptions.elementAt(state.selectedIndex),
                  ),
                ],
              )
              ,

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
          return Container();
        },
      ),
    );
  }
}