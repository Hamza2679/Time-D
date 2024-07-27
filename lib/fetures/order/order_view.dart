import 'package:flutter/material.dart';
import '../common/common.dart';

class OrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: Center(
        child: Text(
          'List of your orders will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
