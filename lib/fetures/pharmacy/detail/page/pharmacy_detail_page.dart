import 'package:flutter/material.dart';
import '../../../../models/pharmacy_model.dart';
import '../../../common/finish_page.dart';

class PharmacyDetailPage extends StatefulWidget {
  final Pharmacy pharmacy;

  PharmacyDetailPage({required this.pharmacy});

  @override
  _PharmacyDetailPageState createState() => _PharmacyDetailPageState();
}

class _PharmacyDetailPageState extends State<PharmacyDetailPage> {
  // Create a map to manage the quantity for each drug
  Map<int, int> _quantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(widget.pharmacy.name, style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.pharmacy.image, width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16.0),
            Text(
              widget.pharmacy.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.pharmacy.address,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 16.0),
            Text(
              'Available Drugs',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.pharmacy.drugs.length,
                itemBuilder: (context, index) {
                  final drug = widget.pharmacy.drugs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        drug.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(drug.name),
                      subtitle: Text('\$${drug.price.toStringAsFixed(2)}'),
                      trailing: _buildQuantitySelector(drug, index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            _buildBuyNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(Drug drug, int index) {
    int quantity = _quantities[index] ?? 0; // Default to 0 if no quantity is set

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (quantity > 0) {
                _quantities[index] = --quantity;
              }
            });
          },
        ),
        Text('$quantity'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _quantities[index] = ++quantity;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBuyNowButton() {
    double totalPrice = _quantities.entries.fold(0.0, (sum, entry) {
      final drug = widget.pharmacy.drugs[entry.key];
      return sum + drug.price * entry.value;
    });

    return Container(

      color: Colors.deepOrange,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: \$${totalPrice.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                    content: Text("Total Price: \$${totalPrice.toStringAsFixed(2)}"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => FinishPage()),
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
    );
  }
}
