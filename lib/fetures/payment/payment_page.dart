import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this for making HTTP requests
import 'dart:convert'; // For encoding the body of the request

import '../../utils/colors.dart';

class PaymentPage extends StatefulWidget {
  final double deliveryFee;
  final double totalFee;
  final String orderId; // Add the orderId

  PaymentPage({
    required this.deliveryFee,
    required this.totalFee,
    required this.orderId, // Initialize orderId
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;

  // Function to handle "Pay Now" option
  Future<void> _handlePayNow() async {
    const String url = 'https://hello-delivery.onrender.com/api/v1/payment';
    const String accessToken = 'your_access_token_here'; // Replace with actual token

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "orderId": widget.orderId, // Passing the orderId in the body
        }),
      );

      if (response.statusCode == 200) {
        // Payment successful, navigate to a success page or show confirmation
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment successful!'),
        ));
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment failed! Please try again.'),
        ));
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  // Function to navigate to the finish page
  void _navigateToFinishPage() {
    Navigator.pushNamed(context, '/finish'); // Replace with the correct route for your finish page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: primaryTextColor)),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivery Fee: \$${widget.deliveryFee.toStringAsFixed(2)}'),
            Text('Total Fee: \$${widget.totalFee.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text('Select Payment Method:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: Text('Pay Now'),
              value: 'now',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Pay After Delivery'),
              value: 'later',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod == 'now') {
                  // If "Pay Now" is selected, make the API request
                  _handlePayNow();
                } else if (_selectedPaymentMethod == 'later') {
                  // If "Pay After Delivery" is selected, navigate to the finish page
                  _navigateToFinishPage();
                } else {
                  // If no option is selected, show a message
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select a payment method'),
                  ));
                }
              },
              child: Text(
                'Confirm Payment',
                style: TextStyle(color: primaryTextColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
