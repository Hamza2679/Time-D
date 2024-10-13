import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';

class GiftsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 30,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, newColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            image: DecorationImage(
              image: AssetImage('assets/appicon.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Stores',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Text('Gifts Page'),
      ),
    );
  }
}
