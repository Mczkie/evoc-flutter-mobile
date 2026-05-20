import 'package:evocapp/screens/splash_screen/startup/second_screen/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(18.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              // Lottie Icon
              Lottie.asset('images/whatLottie.json', height: 290, width: 290),
              SizedBox(
                height: 20,
              ),

              // Title
              Text(
                'Scan. Learn. Act',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),

              SizedBox(
                height: 15,
              ),

              // Description
              Text(
                'Identify waste using your camera and build better eco habits every day.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Button(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
