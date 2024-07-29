import 'package:flutter/material.dart';
import '../widgets/splash_screen.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      imagePath: 'assets/splash2.png', // Replace with your image path
      text: 'Get fast and reliable delivery at your doorstep.',
      onNext: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
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
