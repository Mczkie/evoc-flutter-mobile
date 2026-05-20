import 'package:evocapp/screens/splash_screen/startup/second_screen/second_screen.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen()));
      },
      child: Text(
        "Next",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
