import 'package:evocapp/components/locationItem/locationItem.dart';
import 'package:evocapp/components/userRole/user_role.dart';
import 'package:evocapp/screens/user_screen/normal_user.dart';

import 'package:evocapp/screens/user_screen/student_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({
    super.key,
  });

  @override
  State<SetupPage> createState() => _SetupPageState();
}

String? selectedRoles;

String? selectedLocation;

Widget userContinue() {
  if (selectedRoles == "Student") {
    return StudentScreen();
  } else if (selectedRoles == "Normal User") {
    return NormalUser();
  } else {
    return SetupPage();
  }
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                // Welcome to
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'ECO VISTA',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  child: Text(
                    'Welcome to Eco Vista Olongapo City (EVOC), an app to improve waste segregation and promote sustainability in Olongapo City.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                ),

                Lottie.asset("images/Logins.json", height: 300),
                SizedBox(height: 20),
                UserRole(onSelectedRole: (role) {
                  selectedRoles = role;
                }),
                SizedBox(height: 20),
                MyLocation(onSelectedLocation: (location) {
                  selectedLocation = location;
                }),
                SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  ),
                  onPressed: () {
                    if (selectedRoles != null && selectedLocation != null) {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text("Success!"),
                                content: Text(
                                    "Thank you for fill up the required form successfully!😊"),
                              ));
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userContinue(),
                          ),
                        );
                      });
                    } else if (selectedRoles != null &&
                            selectedLocation == null ||
                        selectedRoles == null && selectedLocation != null) {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                    "Sorry, Please select Valid Location or Role"),
                              ));

                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    } else {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text(
                                    "Sorry, Please fill up the required form"),
                              ));
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
