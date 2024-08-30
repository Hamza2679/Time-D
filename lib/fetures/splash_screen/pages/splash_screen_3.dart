import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';
import '../widgets/splash_screen.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => state.nextScreen),
          );
        }
      },
      child: Scaffold(
        body: SplashScreen(
          imagePath: 'assets/splash2.png',
          text: 'Get fast and reliable delivery at your doorstep.',
          onNext: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          onSkip: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          currentPage: 2,
          totalPages: 3,
        ),
      ),
    );
  }
}
