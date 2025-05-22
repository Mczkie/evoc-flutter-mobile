// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNotificationS extends StatefulWidget {
  const MyNotificationS({super.key});

  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<MyNotificationS> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = false;
  bool _appUpdates = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pushNotifications = prefs.getBool("push_notifications") ?? true;
      _emailNotifications = prefs.getBool("email_notifications") ?? false;
      _smsNotifications = prefs.getBool("sms_notifications") ?? false;
      _appUpdates = prefs.getBool("app_updates") ?? true;
    });
  }

  /// Toggle settings and save to SharedPreferences
  Future<void> _toggleSetting(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    setState(() {
      if (key == "push_notifications") _pushNotifications = value;
      if (key == "email_notifications") _emailNotifications = value;
      if (key == "sms_notifications") _smsNotifications = value;
      if (key == "app_updates") _appUpdates = value;
    });
  }

  /// Check for app updates and install if available
  Future<void> _checkForUpdates() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      } else {
        _showSnackBar("Your app is up to date!");
      }
    } catch (e) {
      _showSnackBar("Error checking updates: $e");
    }
  }

  /// Show a message on the screen
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Settings"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          _buildSwitchTile(
            title: "Push Notifications",
            subtitle: "Receive app notifications",
            value: _pushNotifications,
            onChanged: (val) => _toggleSetting("push_notifications", val),
          ),
          _buildSwitchTile(
            title: "Email Notifications",
            subtitle: "Get updates via email",
            value: _emailNotifications,
            onChanged: (val) => _toggleSetting("email_notifications", val),
          ),
          _buildSwitchTile(
            title: "SMS Notifications",
            subtitle: "Receive alerts through SMS",
            value: _smsNotifications,
            onChanged: (val) => _toggleSetting("sms_notifications", val),
          ),
          _buildSwitchTile(
            title: "App Updates",
            subtitle: "Notify me about new updates",
            value: _appUpdates,
            onChanged: (val) => _toggleSetting("app_updates", val),
          ),
          ListTile(
            title: const Text("Check for App Updates"),
            subtitle: const Text("Tap to check for updates"),
            trailing: ElevatedButton(
              onPressed: _checkForUpdates,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Check"),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to create switch buttons
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }
}
