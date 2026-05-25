import 'package:evocapp/components/locationItem/locationItem.dart';
import 'package:evocapp/components/userRole/user_role.dart';
import 'package:evocapp/components/userName/user_name.dart';
import 'package:evocapp/screens/startup.dart';

import 'package:evocapp/screens/user_screen/student_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  bool isLoading = false;

  String? username;
  String? selectedRoles;
  String? selectedLocation;

  /// SAVE TO SHARED PREFS
  Future<void> saveUserLocally() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", username?.trim() ?? "");
    await prefs.setString("role", selectedRoles ?? "");
    await prefs.setString("location", selectedLocation ?? "");
  }

  /// NAVIGATION BASED ON ROLE
  Widget userContinue() {
    if (selectedRoles == "Student" || selectedRoles == "Normal User") {
      return const StudentScreen();
    } else {
      return const MyStartup(email: "");
    }
  }

  /// API CALL + SAVE LOCAL
  Future<void> fetchUsersAndContinue() async {
    setState(() {
      isLoading = true;
    });

    try {
      final setupResponse = await http.post(
        Uri.parse("https://evoc-backend.onrender.com/api/mobile-users"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": username?.trim(),
          "role": selectedRoles,
          "location": selectedLocation,
        }),
      );

      print("STATUS: ${setupResponse.statusCode}");
      print("BODY: ${setupResponse.body}");

      if (setupResponse.statusCode == 200 || setupResponse.statusCode == 201) {
        /// SAVE LOCALLY FIRST
        await saveUserLocally();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => userContinue()),
        );
      } else {
        throw Exception(setupResponse.body);
      }
    } catch (e) {
      print("ERROR: $e");

      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Error"),
          content: Text("$e"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Spacer(),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Welcome to",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  "ECO VISTA",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome to Eco Vista Olongapo City (EVOC), an app to improve waste segregation and promote sustainability in Olongapo City.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
                Lottie.asset(
                  "images/Logins.json",
                  height: 250,
                ),
                const SizedBox(height: 20),
                UserName(
                  onUsername: (name) => username = name,
                ),
                const SizedBox(height: 20),
                UserRole(
                  onSelectedRole: (role) => selectedRoles = role,
                ),
                const SizedBox(height: 20),
                MyLocation(
                  onSelectedLocation: (location) => selectedLocation = location,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (username != null &&
                              username!.isNotEmpty &&
                              selectedRoles != null &&
                              selectedLocation != null) {
                            showCupertinoDialog(
                              context: context,
                              builder: (_) => const CupertinoAlertDialog(
                                title: Text("Success!"),
                                content: Text(
                                  "Thank you for completing the form 😊",
                                ),
                              ),
                            );

                            await Future.delayed(
                              const Duration(seconds: 2),
                            );

                            Navigator.pop(context);

                            await fetchUsersAndContinue();
                          } else {
                            showCupertinoDialog(
                              context: context,
                              builder: (_) => const CupertinoAlertDialog(
                                title: Text("Missing Fields"),
                                content:
                                    Text("Please fill all required fields"),
                              ),
                            );

                            Future.delayed(
                              const Duration(seconds: 2),
                              () => Navigator.pop(context),
                            );
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
