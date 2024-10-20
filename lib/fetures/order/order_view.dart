import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/colors.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<dynamic> allOrders = [];
  List<dynamic> ongoingOrders = [];
  List<dynamic> completedOrders = [];
  List<dynamic> canceledOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fetchOrders(); // Fetch the orders on page load
  }


  Future<void> _fetchOrders() async {
    const String url = 'https://hello-delivery.onrender.com/api/v1/order/my';

    try {
      // Retrieve the access token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        // Handle case where the token is missing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No access token found. Please log in.')),
        );
        return;
      }

      // Make the API request with the retrieved access token
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Use the token from SharedPreferences
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> orders = json.decode(response.body)['orders'];

        setState(() {
          allOrders = orders;
          ongoingOrders = orders.where((order) {
            return order['status'] == 'accepted' || order['status'] == 'pending';
          }).toList();
          completedOrders = orders.where((order) => order['status'] == 'delivered').toList();
          canceledOrders = orders.where((order) => order['status'] == 'rejected').toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch orders.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: AppBar(
          backgroundColor: primaryColor,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Ongoing'),
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(ongoingOrders, 'No ongoing orders'),
          _buildOrderList(allOrders, 'No orders found'),
          _buildOrderList(completedOrders, 'No completed orders'),
          _buildOrderList(canceledOrders, 'No canceled orders'),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<dynamic> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          title: Text('Order ID: ${order['id']}'),
          subtitle: Text('Status: ${order['status']}'),
          trailing: Text('Total: \$${order['total']}'),
          onTap: () {
            // Handle order tap, e.g., navigate to order details
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
