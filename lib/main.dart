import 'package:delivery_app/fetures/electronics/main/bloc/electronics_bloc.dart';
import 'package:delivery_app/fetures/food/main/bloc/food_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/authentication_repository.dart';
import 'fetures/autentication/login/bloc/login_bloc.dart';
import 'fetures/autentication/otp/bloc/otp_bloc.dart';
import 'fetures/home/bloc/home_bloc.dart';
import 'fetures/pharmacy/main/bloc/pharmacy_bloc.dart';
import 'fetures/pharmacy/main/bloc/pharmacy_event.dart';
import 'fetures/splash_screen/bloc/splash_bloc.dart';
import 'fetures/splash_screen/pages/custom.dart';

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
        BlocProvider(create: (context) => MainBloc()),
        BlocProvider(create: (context) => FoodBloc()),
        BlocProvider(create: (context) => ElectronicsBloc()),
        BlocProvider(create: (context) => PharmacyBloc()..add(LoadPharmacies())),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomSplashScreen(),
      ),
    );
  }
}
