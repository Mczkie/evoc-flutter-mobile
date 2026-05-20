import 'dart:async';

import 'package:evocapp/screens/splash_screen/startup/first_screen/first_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      (() => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstScreen()))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              // App Description
              const Text(
                'Smarter Waste Management Starts With EVOC',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // App Logo
              Image.asset(
                'assets/splash_screen/logo2.png',
                height: 230,
                width: 230,
              ),

              // School and Beneficiary Logo
              Spacer(),
              Align(
                alignment: AlignmentGeometry.bottomCenter,
                child: Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/splash_screen/gc2.png',
                      height: 65,
                      width: 65,
                    ),
                    Image.asset(
                      'assets/splash_screen/esmo2.png',
                      height: 65,
                      width: 65,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "A BS Computer Science thesis project by Mc Peterson C. Mercader and Alexandra Marie De Jesus, Gordon College.",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
