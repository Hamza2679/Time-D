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
            Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage('https://t3.ftcdn.net/jpg/04/83/92/74/360_F_483927409_TLxvOnOkNm1fj6uZT8oO9p5wYvJGuAG7.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  '50% Off on First Order!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(20.0),

            ),


            // Popular Stores/Restaurants
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Popular Restaurants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildStoreCarousel(),

            // Top Deals
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

  Widget _buildCategoryCard(String name, IconData icon) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          SizedBox(height: 10),
          Text(name, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildStoreCarousel() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStoreCard('Store 1', 'https://example.com/store1.jpg', 4.5),
          _buildStoreCard('Store 2', 'https://example.com/store2.jpg', 4.0),
          _buildStoreCard('Store 3', 'https://example.com/store3.jpg', 4.8),
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
