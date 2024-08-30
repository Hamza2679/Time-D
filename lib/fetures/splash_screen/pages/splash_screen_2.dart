import 'package:delivery_app/fetures/splash_screen/pages/splash_screen_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../widgets/splash_screen.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen2 extends StatelessWidget {
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
          imagePath: 'assets/splash1.jpg',
          text: 'Easily find your favorite products. Order from any ware.',
          onNext: () {
            BlocProvider.of<SplashBloc>(context).add(NextScreenEvent(SplashScreen3()));
          },
          onSkip: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          currentPage: 1,
          totalPages: 3,
        ),
      ),
    );
  }
}
