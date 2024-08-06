import 'package:flutter/material.dart';
import '../common/common.dart';

class GiftPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          // title: Text('Hello Delivery',style: TextStyle(fontSize: 5),),
        ),
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
