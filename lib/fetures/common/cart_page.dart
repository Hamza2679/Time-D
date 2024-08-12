import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartProvider.cart.items.length,
        itemBuilder: (context, index) {
          final item = cartProvider.cart.items[index];
          return ListTile(
            title: Text(item.itemName),
            subtitle: Text('${item.restaurantName} - \$${item.price.toStringAsFixed(2)} x ${item.quantity}'),
            trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.deepOrange,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.deepOrange, backgroundColor: Colors.white, // Text color
              ),
              onPressed: () {
                // Handle checkout
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
