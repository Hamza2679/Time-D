import 'package:flutter/material.dart';
import 'package:delivery_app/fetures/autentication/login/pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const SplashScreen({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          // title: Text('Hello Delivery',style: TextStyle(fontSize: 5),),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Spacer(),
              Image.asset(imagePath),
              SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: onNext,
                child: Text('Next', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                ),
              ),
              SizedBox(height: 20,),
              // ElevatedButton(
              //   onPressed: onSkip,
              //   child: Text('Skip' ,style: TextStyle(color: Colors.white),),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.deepOrange,
              //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              //     minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
              //   ),
              // ),
              SizedBox(height: 20), // Add some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
