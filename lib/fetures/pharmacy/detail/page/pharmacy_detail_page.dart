import 'package:delivery_app/utils/colors.dart';
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
        backgroundColor: primaryColor,
        title: Text(widget.pharmacy.name, style: TextStyle(color: primaryTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.pharmacy.image, width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 6.0),
            Text(
              widget.pharmacy.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              widget.pharmacy.address,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 6.0),
            Text(
              'Available Drugs',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.pharmacy.drugs.length,
                itemBuilder: (context, index) {
                  final drug = widget.pharmacy.drugs[index];
                  return Card(
                    elevation: 4.0,  // Add elevation here
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            drug.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(drug.name),
                        subtitle: Text('\$${drug.price.toStringAsFixed(2)}'),
                        trailing: _buildQuantitySelector(drug, index),
                      ),
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
        _buildQuantityButton(
          icon: Icons.remove,
          color: redColor,
          onPressed: () {
            setState(() {
              if (quantity > 0) {
                _quantities[index] = --quantity;
              }
            });
          },
        ),
        SizedBox(width: 8),
        Text(
          '$quantity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        _buildQuantityButton(
          icon: Icons.add,
          color: greenColor,
          onPressed: () {
            setState(() {
              _quantities[index] = ++quantity;
            });
          },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon, color: primaryTextColor),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildBuyNowButton() {
    double totalPrice = _quantities.entries.fold(0.0, (sum, entry) {
      final drug = widget.pharmacy.drugs[entry.key];
      return sum + drug.price * entry.value;
    });

    return Container(
      color: primaryColor,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: \$${totalPrice.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryTextColor),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: primaryColor,
              backgroundColor: primaryTextColor, // Text color
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
            child: Text("Order Now"),
          ),
        ],
      ),
    );
  }
}
