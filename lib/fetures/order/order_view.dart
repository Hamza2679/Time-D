import 'package:flutter/material.dart';
import 'package:delivery_app/utils/colors.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> orderHistory = [
    {
      'orderId': '001',
      'date': '2024-10-01',
      'totalPrice': 29.99,
      'status': 'Pending',
      'items': [
        {'name': 'Burger', 'quantity': 2, 'price': 10.0},
        {'name': 'Fries', 'quantity': 1, 'price': 5.0},
      ],
    },
    {
      'orderId': '002',
      'date': '2024-09-25',
      'totalPrice': 49.99,
      'status': 'Completed',
      'items': [
        {'name': 'Pizza', 'quantity': 1, 'price': 15.0},
        {'name': 'Soda', 'quantity': 2, 'price': 3.0},
      ],
    },
    {
      'orderId': '003',
      'date': '2024-09-30',
      'totalPrice': 19.99,
      'status': 'Canceled',
      'items': [
        {'name': 'Taco', 'quantity': 3, 'price': 6.0},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Three tabs: History, Pending, Canceled
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filtering orders based on status
  List<Map<String, dynamic>> getOrdersByStatus(String status) {
    return orderHistory.where((order) => order['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryColor,
          indicatorColor: primaryColor, // Set the color of the indicator
          tabs: [
            Tab(text: 'History',),
            Tab(text: 'Pending'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // History Orders
          OrderListView(orders: getOrdersByStatus('Completed')),

          // Pending Orders
          OrderListView(orders: getOrdersByStatus('Pending')),

          // Canceled Orders
          OrderListView(orders: getOrdersByStatus('Canceled')),
        ],
      ),
    );
  }
}

// This widget is used to display the order list based on status (History, Pending, Canceled)
class OrderListView extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrderListView({required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No orders available',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              order['status'] == 'Pending'
                  ? Icons.hourglass_empty
                  : order['status'] == 'Completed'
                  ? Icons.check_circle
                  : Icons.cancel,
              color: order['status'] == 'Pending'
                  ? Colors.orange
                  : order['status'] == 'Completed'
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text('Order #${order['orderId']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${order['date']}'),
                Text('Total: \$${order['totalPrice'].toStringAsFixed(2)}'),
                Text('Status: ${order['status']}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                // Navigate to a detailed order view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(order: order),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order['orderId']}'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Order ID: ${order['orderId']}'),
            Text('Date: ${order['date']}'),
            Text('Status: ${order['status']}'),
            SizedBox(height: 10),
            Divider(),
            Text(
              'Items Ordered',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  return ListTile(
                    leading: Text('${item['quantity']}x'),
                    title: Text(item['name']),
                    trailing: Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Total: \$${order['totalPrice'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
