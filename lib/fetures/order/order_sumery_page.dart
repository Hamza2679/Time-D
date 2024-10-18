import 'package:flutter/material.dart';
import 'package:delivery_app/utils/colors.dart';

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
  double deliveryFee = 50;
  String selectedAddressOption = 'auto';
  String selectedPaymentMethod = 'after_delivery';

  TextEditingController manualAddressController = TextEditingController();
  TextEditingController streetController = TextEditingController();

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

  double getTotalPrice() {
    double total = 0.0;
    List<Map<String, dynamic>> filteredProducts = getFilteredProducts();
    List<int> filteredQuantities = getFilteredQuantities();
    for (int i = 0; i < filteredProducts.length; i++) {
      total += (filteredProducts[i]['price'] ?? 0.0) * filteredQuantities[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Use filtered products and quantities for displaying and calculating totals
    final filteredProducts = getFilteredProducts();
    final filteredQuantities = getFilteredQuantities();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary',style: TextStyle(color: primaryTextColor),),
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
                shrinkWrap: true, // To prevent taking up extra space
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
              // Payment Method Section
              Text(
                'Select Payment Method:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'after_delivery',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  Text('Pay After Delivery'),
                  Radio(
                    value: 'credit_card',
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value.toString();
                      });
                    },
                  ),
                  Text('Pay now'),
                ],
              ),
              SizedBox(height: 20),
              // Total Price Section
              Text(
                'Total: \$${(getTotalPrice() + deliveryFee).toStringAsFixed(2)} (Delivery: \$${deliveryFee.toStringAsFixed(2)})',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Confirm Order Button
              ElevatedButton(
                onPressed: () {
                  // Logic for confirming order
                  print('Order confirmed');
                },
                child: Text('Confirm Order', style: TextStyle(color: primaryTextColor),),
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
