import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../payment/payment_page.dart';

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
  String selectedAddressOption = 'auto'; // Default to auto
  TextEditingController manualAddressController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    if (selectedAddressOption == '') {
      _determinePosition(); // Automatically detect location when auto is selected
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    print('Current location: Lat: $latitude, Lon: $longitude');
  }

  Future<void> confirmOrder() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      List<Map<String, dynamic>> products = [];
      final filteredProducts = getFilteredProducts();
      final filteredQuantities = getFilteredQuantities();
      for (int i = 0; i < filteredProducts.length; i++) {
        products.add({
          'productId': filteredProducts[i]['productId'],
          'quantity': filteredQuantities[i],
        });
      }

      double finalLatitude = selectedAddressOption == 'auto' ? latitude : 0.0;
      double finalLongitude = selectedAddressOption == 'auto' ? longitude : 0.0;

      final Map<String, dynamic> requestBody = {
        'products': products,
        'latitude': finalLatitude,
        'longitude': finalLongitude,
      };

      final response = await http.post(
        Uri.parse('https://hello-delivery.onrender.com/api/v1/order'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      double deliveryFee = 0.0;
      double total_product_price =0.0;
      double totalFee = 0.0;
      String orderId = "";

      if (response.statusCode == 200 || response.statusCode == 201) {
        var orderResponse = json.decode(response.body);

        if (orderResponse is List && orderResponse.isNotEmpty) {
          deliveryFee = orderResponse[0]['totalDeliveryFee'] ?? 0.0;
          totalFee = orderResponse[0]['totalAmount'] ?? 0.0;
          total_product_price = orderResponse[0]['totalProductPrice'] ?? 0.0;
          orderId = orderResponse[0]['id']?? "";
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              deliveryFee: deliveryFee,
              totalFee: totalFee,
              orderId: orderId,
              totalProductPrice: total_product_price,
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
                      'price : \$${((product['price'] ?? 0.0) * filteredQuantities[index]).toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedAddressOption.isEmpty ? '' : selectedAddressOption,
                items: [
                  DropdownMenuItem(
                    value: '',
                    child: Text('Select Delivery Address:'),
                  ),
                  DropdownMenuItem(
                    value: 'auto',
                    child: Text('Auto Detect'),
                  ),
                  DropdownMenuItem(
                    value: 'manual',
                    child: Text('Enter Manually'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedAddressOption = value!;
                    if (selectedAddressOption == 'auto') {
                      _determinePosition(); // Call method to auto-detect position
                    }
                  });
                },
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
              ElevatedButton(
                onPressed: confirmOrder,
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

  List<Map<String, dynamic>> getFilteredProducts() {
    List<Map<String, dynamic>> filteredProducts = [];
    for (int i = 0; i < widget.selectedProducts.length; i++) {
      if (widget.quantities[i] > 0) {
        filteredProducts.add(widget.selectedProducts[i]);
      }
    }
    return filteredProducts;
  }

  List<int> getFilteredQuantities() {
    List<int> filteredQuantities = [];
    for (int i = 0; i < widget.quantities.length; i++) {
      if (widget.quantities[i] > 0) {
        filteredQuantities.add(widget.quantities[i]);
      }
    }
    return filteredQuantities;
  }
}
