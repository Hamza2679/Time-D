import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,


      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Column(
              children: [
                Container(
                  height: 180,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/com.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 180,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaAQOgtS41sfTsJSXM4e48ljj5dyNFYDu8vQ&s'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '50% Off on First Order!',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Popular Restaurants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildStoreCarousel(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Top Deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildDealCard(),
          ],
        ),
      ),

    );
  }



  Widget _buildStoreCarousel() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStoreCard('Store 1', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHgwWivilxxH1eAitAAZhuVpA-UV8ldD3VWg&s', 4.5),
          _buildStoreCard('Store 2', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdTKo1SgPATsCrA4rNw-ADARsZVHBSR6KAyg&s', 4.0),
          _buildStoreCard('Store 3', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6QE34KKvZXw7bOM7nUSkffAU46hzwL25xfg&s', 4.8),
        ],
      ),
    );
  }

  Widget _buildStoreCard(String name, String imageUrl, double rating) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.black54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: TextStyle(color: Colors.white)),
              Text('$rating ★', style: TextStyle(color: Colors.yellow)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDealCard() {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          'Buy 1 Get 1 Free on All Burgers!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
