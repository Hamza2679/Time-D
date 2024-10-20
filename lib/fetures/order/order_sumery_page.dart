import 'package:flutter/material.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For token management
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:convert';

import '../payment/payment_page.dart'; // For JSON encoding/decoding

class OrderSummaryPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;
  final List<int> quantities;

  OrderSummaryPage({
    required this.selectedProducts,
    required this.quantities,
  });

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  String selectedAddressOption = 'auto';
  TextEditingController manualAddressController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  final double defaultLatitude = 6.5244; // Default latitude
  final double defaultLongitude = 3.3792; // Default longitude

  // Filter out products where the quantity is greater than 0
  List<Map<String, dynamic>> getFilteredProducts() {
    List<Map<String, dynamic>> filteredProducts = [];
    for (int i = 0; i < widget.selectedProducts.length; i++) {
      if (widget.quantities[i] > 0) {
        filteredProducts.add(widget.selectedProducts[i]);
      }
    }
    return filteredProducts;
  }

  // Get the filtered quantities corresponding to filtered products
  List<int> getFilteredQuantities() {
    List<int> filteredQuantities = [];
    for (int i = 0; i < widget.quantities.length; i++) {
      if (widget.quantities[i] > 0) {
        filteredQuantities.add(widget.quantities[i]);
      }
    }
    return filteredQuantities;
  }

  Future<void> confirmOrder() async {
    try {
      // Retrieve the access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      // Ensure the token is available
      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Prepare the products for the request
      List<Map<String, dynamic>> products = [];
      final filteredProducts = getFilteredProducts();
      final filteredQuantities = getFilteredQuantities();
      for (int i = 0; i < filteredProducts.length; i++) {
        products.add({
          'productId': filteredProducts[i]['productId'],
          'quantity': filteredQuantities[i],
        });
      }

      // Create the request payload
      final Map<String, dynamic> requestBody = {
        'products': products,
        'latitude': defaultLatitude,
        'longitude': defaultLongitude,
      };

      // Make the API request
      final response = await http.post(
        Uri.parse('https://hello-delivery.onrender.com/api/v1/order'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      // Log response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Initialize default values for deliveryFee and totalFee
      double deliveryFee = 0.0;
      double totalFee = 0.0;
      String ordeId = "";

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        var orderResponse = json.decode(response.body);

        // Check if response is an object or a list
        if (orderResponse is List && orderResponse.isNotEmpty) {
          deliveryFee = orderResponse[0]['totalDeliveryFee'] ?? 0.0;
          totalFee = orderResponse[0]['totalAmount'] ?? 0.0;
          ordeId = orderResponse[0]['id']?? 0.0;
        } else if (orderResponse is Map) {
          deliveryFee = orderResponse['totalDeliveryFee'] ?? 0.0;
          totalFee = orderResponse['totalAmount'] ?? 0.0;
          ordeId = orderResponse['id'] ?? 0.0;
        }

        // Navigate to PaymentPage with the fees
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              deliveryFee: deliveryFee,
              totalFee: totalFee,
              orderId: ordeId
            ),
          ),
        );
      } else {
        throw Exception('Failed to confirm order');
      }
    } catch (e) {
      print('Error confirming order: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final filteredProducts = getFilteredProducts();
    final filteredQuantities = getFilteredQuantities();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary', style: TextStyle(color: primaryTextColor)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filteredProducts.isEmpty
                  ? Center(
                child: Text(
                  'No items with quantity greater than 0',
                  style: TextStyle(fontSize: 18, color: primaryTextColor),
                ),
              )
                  : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ListTile(
                    leading: Image.network(
                      product['image'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image);
                      },
                    ),
                    title: Text(product['name'] ?? ''),
                    subtitle: Text('Quantity: ${filteredQuantities[index]}'),
                    trailing: Text(
                      '\$${(product['price'] ?? 0.0) * filteredQuantities[index]}',
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // Delivery Address Section
              Text(
                'Select Delivery Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'auto',
                    groupValue: selectedAddressOption,
                    onChanged: (value) {
                      setState(() {
                        selectedAddressOption = value.toString();
                      });
                    },
                  ),
                  Text('Auto Detect'),
                  Radio(
                    value: 'manual',
                    groupValue: selectedAddressOption,
                    onChanged: (value) {
                      setState(() {
                        selectedAddressOption = value.toString();
                      });
                    },
                  ),
                  Text('Enter Manually'),
                ],
              ),
              if (selectedAddressOption == 'manual') ...[
                TextField(
                  controller: manualAddressController,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                  ),
                ),
                TextField(
                  controller: streetController,
                  decoration: InputDecoration(
                    labelText: 'Street',
                  ),
                ),
              ],
              SizedBox(height: 20),
              // Confirm Order Button
              ElevatedButton(
                onPressed: confirmOrder, // Call the confirm order function
                child: Text(
                  'Confirm Order',
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
      ),
    );
  }
}
