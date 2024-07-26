import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fetures/autentication/login/pages/login_page.dart';
import 'fetures/autentication/login/bloc/login_bloc.dart';
import 'fetures/autentication/otp/bloc/otp_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => OtpBloc()),
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
