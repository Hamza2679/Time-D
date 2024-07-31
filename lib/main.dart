import 'package:delivery_app/fetures/splash_screen/pages/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fetures/autentication/login/bloc/login_bloc.dart';
import 'fetures/autentication/login/pages/login_page.dart';
import 'fetures/autentication/otp/bloc/otp_bloc.dart';
import 'fetures/home/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  print("Is Logged In in main: $isLoggedIn"); // Debug print
  runApp(MyApp(isLoggedIn: isLoggedIn));
}


class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OtpBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? MainPage() : SplashScreen1(),
       //  home:LoginPage()
      ),
    );
  }
}
