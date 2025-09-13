// ignore_for_file: use_build_context_synchronously

import 'package:evocapp/screens/menu_pages/faqs.dart';
import 'package:evocapp/screens/menu_pages/legal_information.dart';
import 'package:evocapp/screens/menu_pages/notificatinSettings.dart';
import 'package:evocapp/screens/menu_pages/privacySettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:evocapp/database/db_helper.dart';
import 'package:evocapp/screens/loginpage.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          _buildMenuItem(context, "Privacy Settings", MyPrivacy()),
          _buildMenuItem(context, "Notification Settings", MyNotificationS()),
          _buildMenuItem(context, "FAQS", MyFAQS()),
          _buildMenuItem(context, "Legal Information", MyInformation()),
          const ListTile(
            title: Text("App Version"),
            trailing:
                Text("1.0.1", style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 16), // Button padding
              ),
              child: const Text(
                'Logout',
                style:
                    TextStyle(fontSize: 16, color: Colors.white), // Text style
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final DbHelper dbHelper = DbHelper();
    await dbHelper.updatedLoginStatus(email, 0);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyLoginPage(email: email),
      ),
    );
  }
}

Widget _buildMenuItem(BuildContext context, String title, Widget page) {
  return ListTile(
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
  );
}
