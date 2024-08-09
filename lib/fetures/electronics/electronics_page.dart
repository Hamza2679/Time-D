import 'package:flutter/material.dart';

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
      "items": [
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"}
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "items": [
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"}
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "items": [
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"}
      ]
    },
    {
      "name": "Best Buy",
      "location": "123 Main St",
      "items": [
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"},
        {"name": "Laptop", "price": "1000"},
        {"name": "Phone", "price": "500"}
      ]
    },

    {
      "name": "Tech Store",
      "location": "456 Elm St",
      "items": [
        {"name": "Tablet", "price": "300"},
        {"name": "Smartwatch", "price": "200"}
      ]
    }
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
      appBar: AppBar(
        title: Text('Electronics Shops'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ElectronicsSearchDelegate(_electronics),
              );
            },
          ),
        ],
      ),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: electronics.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(electronics[index]['name']),
          subtitle: Text(electronics[index]['location']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ElectronicsDetailPage(shop: electronics[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ElectronicsSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> electronics;

  ElectronicsSearchDelegate(this.electronics);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = electronics.where((shop) {
      return shop['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return buildElectronicsList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = electronics.where((shop) {
      return shop['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return buildElectronicsList(context, suggestions);
  }

  Widget buildElectronicsList(BuildContext context, List<Map<String, dynamic>> electronics) {
    return ListView.builder(
      itemCount: electronics.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(electronics[index]['name']),
          subtitle: Text(electronics[index]['location']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ElectronicsDetailPage(shop: electronics[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ElectronicsDetailPage extends StatelessWidget {
  final Map<String, dynamic> shop;

  ElectronicsDetailPage({required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shop['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(shop['location']),
            SizedBox(height: 10),
            Text('Items:'),
            Expanded(
              child: ListView.builder(
                itemCount: shop['items'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(shop['items'][index]['name']),
                    subtitle: Text('Price: \$${shop['items'][index]['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
