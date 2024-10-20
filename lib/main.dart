import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'utils/authentication_repository.dart';
import 'fetures/home/bloc/home_bloc.dart';
import 'fetures/splash_screen/bloc/splash_bloc.dart';
import 'fetures/splash_screen/pages/custom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<AuthenticationRepository>(() async => AuthenticationRepository());
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => MainBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomSplashScreen(),
      ),
    );
  }
}