import 'package:flutter/material.dart';

class EsmoDate extends StatelessWidget {
  const EsmoDate({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('ESMO Schedule'),
                content: SizedBox(
                  height: 350,
                  width: double.maxFinite,
                  child: Image.asset(
                    'images/studentHome/esmoDateChart.png',
                    width: 400,
                    fit: BoxFit.fill,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/studentHome/esmoDateChart.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
