import 'package:flutter/material.dart';
import '../widgets/splash_screen.dart';
import 'splash_screen_2.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      imagePath: 'assets/splash1.png', // Replace with your image path
      text: 'Welcome to Delivery App! Discover new experiences.',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen2()),
        );
      },
      onSkip: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
      },
    );
  }
}
