import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';
import '../common/finish_page.dart';

class PaymentPage extends StatefulWidget {
  final double deliveryFee;
  final double totalFee;
  final double totalProductPrice;
  final String orderId;

  PaymentPage({
    required this.deliveryFee,
    required this.totalProductPrice,
    required this.totalFee,
    required this.orderId,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  bool isProcessingPayment = false;


  Future<void> _handlePayNow() async {
    const String url = 'https://hello-delivery.onrender.com/api/v1/payment';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No access token found. Please log in again.'),
        ));
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "orderId": widget.orderId,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment successful!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment failed! Please try again.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  void _navigateToFinishPage() {
    Navigator.pushNamed(context, '/finish');
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
            Text('Product price: \$${widget.totalProductPrice.toStringAsFixed(2)}'),
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
              onPressed: () async {
                if (_selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select a payment method')),
                  );
                  return;
                }

                setState(() {
                  isProcessingPayment = true;
                });

                if (_selectedPaymentMethod == 'now') {
                  await _handlePayNow();
                } else if (_selectedPaymentMethod == 'later') {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FinishPage()));
                }

                setState(() {
                  isProcessingPayment = false;
                });
              },
              child: isProcessingPayment
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryTextColor),
              )
                  : Text(
                'Confirm',
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
