import 'package:flutter/material.dart';
import 'package:delivery_app/utils/colors.dart';

import '../order/order_sumery_page.dart';

class OrganizationDetailPage extends StatefulWidget {
  final String organizationName;
  final List<Map<String, dynamic>>? products;


  OrganizationDetailPage({required this.organizationName, required this.products});

  @override
  _OrganizationDetailPageState createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  List<int> quantities = [];
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.products?.length ?? 0, 0);
  }

  double getTotalPrice() {
    double total = 0.0;
    for (int index = 0; index < widget.products!.length; index++) {
      final price = widget.products![index]['price'] ?? 0.0;
      total += price * quantities[index];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final productList = widget.products ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.organizationName, style: TextStyle(color: primaryTextColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: productList.isEmpty
            ? Center(
          child: Text(
            'No Products Available',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image on the left
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              product['image'] ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'] ?? 'Unknown Product',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${(product['price'] ?? 0.0).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green[700],
                                  ),
                                ),
                                SizedBox(height: 8),
                                // Quantity controls
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (quantities[index] > 0) {
                                            quantities[index]--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      quantities[index].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          quantities[index]++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Order summary section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${getTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isNavigating = true;
                      });
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSummaryPage(
                            selectedProducts: widget.products!,
                            quantities: quantities,
                          ),
                        ),
                      );

                      setState(() {
                        isNavigating = false;
                      });
                    },
                    child: isNavigating
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    )
                        : Text(
                      'Order Now',
                      style: TextStyle(color: primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
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
