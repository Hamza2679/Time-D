import 'package:flutter/material.dart';
import '../common/common.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text(
          'Your profile information will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
