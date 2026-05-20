import 'package:evocapp/screens/splash_screen/startup/first_screen/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              // Lottiie Icons
              Lottie.asset('images/helloLottie.json', height: 290, width: 290),
              SizedBox(
                height: 25,
              ),

              // Title Evoc
              Text(" Welcome to Eco Vista",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),

              // Evoc Description
              Text(
                textAlign: TextAlign.center,
                "Eco Vista Olongapo City (EVOC) is an app to improve waste segregation and promote sustainability in Olongapo City..",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 30),
              Button(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
