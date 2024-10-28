import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/colors.dart';
import '../../utils/colors.dart';
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
  String selectedAddressOption = '';
  TextEditingController manualAddressController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  bool isConfirmingOrder = false;

  @override
  void initState() {
    super.initState();
    if (selectedAddressOption == '') {
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showServiceNotAvailableDialog();
      return;
    }

    // Check and request permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showServiceNotAvailableDialog();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showServiceNotAvailableDialog();
      return;
    }

    // If permission is granted, get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    print('Current location: Lat: $latitude, Lon: $longitude');
  }

  void _showServiceNotAvailableDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Service Not Available'),
        content: Text('Location services are required to proceed with the order.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
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
      double total_product_price = 0.0;
      double totalFee = 0.0;
      String orderId = "";

      if (response.statusCode == 200 || response.statusCode == 201) {
        var orderResponse = json.decode(response.body);
        deliveryFee = orderResponse['totalDeliveryFee'] ?? 0.0;
        totalFee = orderResponse['totalAmount'] ?? 0.0;
        total_product_price = orderResponse['totalProductPrice'] ?? 0.0;
        orderId = orderResponse['id'] ?? "";

        if (deliveryFee > 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Service not available in your location'),
              backgroundColor: Colors.red,
            ),
          );


          await Future.delayed(Duration(seconds: 5));
          return;
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
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
                      _determinePosition();
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
                onPressed: () async {
                  setState(() {
                    isConfirmingOrder = true;
                  });
                  await confirmOrder();
                  setState(() {
                    isConfirmingOrder = false;
                  });
                },
                child: isConfirmingOrder
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryTextColor),
                )
                    : Text(
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
