import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String name;
  final String image;
  final String address;
  final List<Map<String, String>> menu;

  RestaurantDetailPage({
    required this.name,
    required this.image,
    required this.address,
    required this.menu,
  });

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Map<int, int> quantities = {};
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.menu.length; i++) {
      quantities[i] = 0;
    }
  }

  void _updateTotalPrice() {
    double newTotal = 0.0;
    quantities.forEach((index, quantity) {
      double price = double.parse(widget.menu[index]["price"]!.substring(1));
      newTotal += price * quantity;
    });
    setState(() {
      _totalPrice = newTotal;
    });
  }

  void _incrementQuantity(int index) {
    setState(() {
      quantities[index] = quantities[index]! + 1;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (quantities[index]! > 0) {
        quantities[index] = quantities[index]! - 1;
        _updateTotalPrice();
      }
    });
  }

  void _buyNow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Order Summary"),
          content: Text("Total Price: \$$_totalPrice"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.image, width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(widget.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.address, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 16),
            Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.menu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(widget.menu[index]["image"]!, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(widget.menu[index]["name"]!),
                    subtitle: Text(widget.menu[index]["price"]!),
                    trailing: Container(
                      width: 120,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decrementQuantity(index),
                          ),
                          Text(quantities[index].toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _incrementQuantity(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: \$$_totalPrice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _buyNow,
                  child: Text("Buy Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
