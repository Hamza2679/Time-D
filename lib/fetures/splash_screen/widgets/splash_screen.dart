// splash_screen.dart
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const SplashScreen({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
           title: Text('Hello Delivery',style: TextStyle(color: Colors.white),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Image.asset(imagePath),
            SizedBox(height: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: onNext,
              child: Text('Next',style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSkip,
              child: Text('Skip' ,style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
