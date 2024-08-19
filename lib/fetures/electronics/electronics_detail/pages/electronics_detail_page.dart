import 'package:flutter/material.dart';

import '../../../common/finish_page.dart';

class ElectronicsDetailPage extends StatefulWidget {
  final Map<String, dynamic> shop;

  ElectronicsDetailPage({required this.shop});

  @override
  _ElectronicsDetailPageState createState() => _ElectronicsDetailPageState();
}

class _ElectronicsDetailPageState extends State<ElectronicsDetailPage> {
  Map<String, int> quantities = {}; // To track the quantity of each item

  @override
  void initState() {
    super.initState();
    // Initialize quantities with 1 for each item
    widget.shop['items'].forEach((item) {
      quantities[item['name']] = 0;
    });
  }

  double getTotalPrice() {
    double total = 0;
    widget.shop['items'].forEach((item) {
      total += double.parse(item['price']) * (quantities[item['name']] ?? 1);
    });
    return total;
  }

  void updateQuantity(String itemName, int change) {
    setState(() {
      if (quantities[itemName]! + change > 0) {
        quantities[itemName] = quantities[itemName]! + change;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the shop image
            Center(
              child: Image.asset(
                widget.shop['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.shop['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(widget.shop['location']),
            SizedBox(height: 10),
            Text('Items:'),
            Expanded(
              child: ListView.builder(
                itemCount: widget.shop['items'].length,
                itemBuilder: (context, index) {
                  var item = widget.shop['items'][index];
                  return ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Text('Price: \$${item['price']}'),
                    trailing: Container(
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              updateQuantity(item['name'], -1);
                            },
                          ),
                          Text('${quantities[item['name']]}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              updateQuantity(item['name'], 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.deepOrange,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: \$${getTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepOrange,
                      backgroundColor: Colors.white, // Text color
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Order Summary"),
                            content: Text(
                              "Total Price: \$${getTotalPrice().toStringAsFixed(2)}",
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FinishPage(),
                                    ),
                                        (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Buy Now"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
