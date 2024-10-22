import 'package:delivery_app/fetures/home/pages/discover_page.dart';
import 'package:delivery_app/fetures/notification/notification_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../order/order_view.dart';
import '../../profile/pages/profile_view.dart';
import '../widgets/main_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static List<Widget> _widgetOptions = <Widget>[
    DiscoverPage(),
    OrderView(),
    ProfileView(),
  ];

  final bool hasUnreadNotifications = true;

  late final PageController _pageController;
  late VideoPlayerController _videoController;

  List<String> adImages = [
    'assets/ad4.png',
    'assets/ad6.png',
    'assets/ad1.png',
    'assets/ad2.png',
    'assets/ad3.png',
    'assets/ad5.png'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _videoController = VideoPlayerController.asset('assets/fsvideo.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _videoController.setLooping(true);
    _videoController.play();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    BlocProvider.of<MainBloc>(context).add(ItemTapped(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_pageController.hasClients &&
                  (_pageController.page?.round() ?? 0) != state.selectedIndex) {
                _pageController.animateToPage(
                  state.selectedIndex,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            });

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(5.0),
                child: AppBar(
                  backgroundColor: primaryColor,
                ),
              ),
              body: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: _widgetOptions.map((widget) {
                  if (widget is DiscoverPage) {
                    return NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: buildSearchBar(
                                          height: 40,
                                          onChanged: (query) {
                                            BlocProvider.of<MainBloc>(context)
                                                .add(SearchQueryChanged(query));
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
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: redColor,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                constraints: BoxConstraints(
                                                  minWidth: 16,
                                                  minHeight: 16,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '3',
                                                    style: TextStyle(
                                                      color: primaryTextColor,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: adImages.length ,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Card(
                                            color: primaryColor,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: 280,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),
                                                child: _videoController.value.isInitialized
                                                    ? VideoPlayer(_videoController)
                                                    : Center(child: CircularProgressIndicator()),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Card(
                                            color: primaryColor,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Container(
                                              width: 280,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),
                                                child: Image.asset(
                                                  adImages[index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 12),
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
                                        'Featured Categories',
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7),
                                buildCategories(context, state.currentCategory),
                              ],
                            ),
                          ),
                        ];
                      },
                      body: state.selectedIndex == 0
                          ? (state.filteredItems.isNotEmpty
                          ? buildSearchResults(state.currentCategory, state.filteredItems)
                          : buildCategoryPage(state.currentCategory))
                          : _widgetOptions.elementAt(state.selectedIndex),
                    );
                  } else {
                    return widget;
                  }
                }).toList(),
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
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
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