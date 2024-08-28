import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Settings",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        ),

      body: Center(
        child: Text(
          'there is no settings yet',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
