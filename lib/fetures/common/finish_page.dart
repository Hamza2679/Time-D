import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:flutter/material.dart';

class FinishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryTextColor,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
    child: AppBar(
    backgroundColor: primaryColor,
    title: Text("Hello Delivery", style: TextStyle(color: primaryTextColor)),
    ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/sucsess.png', // Replace with your asset image
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You successfully created an order,\nenjoy our service!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: greyColor,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil( context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,);
              },
              child: Text('Back To Home' ,style: TextStyle(color: primaryTextColor),),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
