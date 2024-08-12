import 'package:delivery_app/fetures/autentication/otp/pages/otp_page.dart';
import 'package:delivery_app/fetures/home/pages/main_page.dart';
import 'package:delivery_app/fetures/splash_screen/pages/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentication_repository.dart';
import 'fetures/autentication/login/bloc/login_bloc.dart';
import 'fetures/autentication/otp/bloc/otp_bloc.dart';
import 'fetures/home/bloc/home_bloc.dart';
import 'fetures/splash_screen/bloc/splash_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthenticationRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OtpBloc()),
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => MainBloc())  // Provide the MainBloc here
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen1(),
      ),
    );
  }
}
