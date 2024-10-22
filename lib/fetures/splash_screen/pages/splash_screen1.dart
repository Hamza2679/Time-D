import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../widgets/splash_screen.dart';
import 'package:delivery_app/fetures/splash_screen/pages/splash_screen_2.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          _navigateToNextScreen(context, state.nextScreen);
        }
      },
      child: Scaffold(
        body: SplashScreen(
          imagePath: 'assets/splash.png',
          text: 'Welcome to Time Delivery App! Discover new experiences.',
          onNext: () {
            BlocProvider.of<SplashBloc>(context).add(NextScreenEvent(SplashScreen2()));
          },
          onSkip: () {
            _navigateToNextScreen(context, LoginPage());
          },
          currentPage: 0,
          totalPages: 3,
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
