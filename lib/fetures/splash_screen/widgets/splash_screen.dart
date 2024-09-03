import 'package:flutter/material.dart';
import 'package:delivery_app/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final int currentPage;
  final int totalPages;

  const SplashScreen({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onNext,
    required this.onSkip,
    required this.currentPage,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Hello Delivery',
            style: TextStyle(color: primaryTextColor),
          ),
          elevation: 0,
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            onNext();
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imagePath),
                  SizedBox(height: 20),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      totalPages,
                          (index) => buildDot(index: index),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onNext,
                    icon: Icon(Icons.navigate_next, color: primaryColor),
                    label: Text(
                      'next',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onNext,

                    icon: Icon(Icons.navigate_next, color: primaryColor),
                    label: Text(
                      'next',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: onSkip,
                    label: Text(
                      'Skip',
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                    icon: Icon(Icons.fast_forward, color: primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: currentPage == index ? primaryColor : greyColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
