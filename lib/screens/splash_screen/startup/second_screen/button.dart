import 'package:evocapp/screens/setup_page/setup_page.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          backgroundColor: Colors.green),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SetupPage()));
      },
      child: Text(
        "Let's start",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
