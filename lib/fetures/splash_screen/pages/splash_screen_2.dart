import 'package:flutter/material.dart';
import '../widgets/splash_screen.dart';
import 'splash_screen_3.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      imagePath: 'assets/splash2.png', // Replace with your image path
      text: 'Easily find your favorite products.',
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen3()),
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
