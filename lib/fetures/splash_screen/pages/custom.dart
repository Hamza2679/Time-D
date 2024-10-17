import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [

          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/appicon.jpg'),
            ),
          ),

          // Loading text and progress indicator
          Positioned(
            bottom: 170,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'wait a moment...',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                CircularProgressIndicator(color: primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
