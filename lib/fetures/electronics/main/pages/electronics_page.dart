import 'package:flutter/material.dart';
import '../../electronics_detail/pages/electronics_detail_page.dart';

class ElectronicsPage extends StatefulWidget {
  @override
  _ElectronicsPageState createState() => _ElectronicsPageState();
}

class _ElectronicsPageState extends State<ElectronicsPage> {
  String _searchQuery = '';
  List<Map<String, dynamic>> _electronics = [
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore1.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore2.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore3.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore4.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore5.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore6.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Tech Store",
      "location": "456 Elm St",
      "image": "assets/Estore2.jpg",
      "items": [
        {"name": "Tablet", "price": "300", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "200", "image": "assets/smartwatch.jpg"}
      ]
    }, {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore1.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore2.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore3.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore4.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore5.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore6.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore1.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore2.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore3.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore4.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore5.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore6.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore1.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore2.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore3.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore4.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore5.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "image": "assets/Estore6.jpg",
      "items": [
        {"name": "Tablet", "price": "30000", "image": "assets/tablet.jpg"},
        {"name": "Smartwatch", "price": "2000", "image": "assets/smart_watch.jpg"},
        {"name": "Laptop", "price": "100000", "image": "assets/laptop.jpg"},
        {"name": "Phone", "price": "15000", "image": "assets/phone.jpg"},
        {"name": "camera", "price": "3000", "image": "assets/camera.jpg"},
        {"name": "drone", "price": "20000", "image": "assets/drone.jpg"},
        {"name": "eirbud", "price": "1000", "image": "assets/eairbuds.jpg"},
        {"name": "haeaset", "price": "500", "image": "assets/headset.jpg"},
        {"name": "speaker", "price": "300", "image": "assets/speaker.jpg"},
        {"name": "4k hd tv", "price": "200", "image": "assets/tv.jpg"},
      ]
    },
  ];
  bool _isLoading = false;

  List<Map<String, dynamic>> _filteredElectronics() {
    if (_searchQuery.isEmpty) {
      return _electronics;
    }
    return _electronics.where((shop) {
      bool matchesShopName = shop["name"]!.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesItems = shop["items"]!.any((item) {
        return item["name"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item["price"]!.toString().contains(_searchQuery);
      });
      return matchesShopName || matchesItems;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Electronics Shops',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              buildElectronicsList(context, _filteredElectronics()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildElectronicsList(BuildContext context, List<Map<String, dynamic>> electronics) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: electronics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5/ 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElectronicsDetailPage(shop: electronics[index]), // Navigate to the detail page
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    electronics[index]['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        electronics[index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(electronics[index]['location']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
