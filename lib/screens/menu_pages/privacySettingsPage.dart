// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MyPrivacy extends StatefulWidget {
  const MyPrivacy({super.key});

  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<MyPrivacy> {
  // State variables for privacy settings
  bool _locationAccess = false;

  // Location object for handling location services
  Location location = Location();

  // Function to handle location access toggle
  Future<void> _toggleLocationAccess(bool value) async {
    try {
      print("Toggling location access: $value");

      if (value) {
        // Check if location services are enabled
        bool serviceEnabled = await location.serviceEnabled();
        print("Location services enabled: $serviceEnabled");

        if (!serviceEnabled) {
          // Request to enable location services
          serviceEnabled = await location.requestService();
          print("Location services enabled after request: $serviceEnabled");

          if (!serviceEnabled) {
            // If services are still not enabled, show a message and exit
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Location services are disabled.")),
              );
            }
            return;
          }
        }

        // Check location permissions
        PermissionStatus permissionStatus = await location.hasPermission();
        print("Location permission status: $permissionStatus");

        if (permissionStatus == PermissionStatus.denied) {
          // Request location permissions
          permissionStatus = await location.requestPermission();
          print("Location permission status after request: $permissionStatus");

          if (permissionStatus != PermissionStatus.granted) {
            // If permissions are not granted, show a message and exit
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Location permissions are denied.")),
              );
            }
            return;
          }
        }

        // Fetch the current location (optional)
        LocationData locationData = await location.getLocation();
        print("Location: ${locationData.latitude}, ${locationData.longitude}");
      }

      // Update the state to reflect the new toggle value
      if (mounted) {
        setState(() {
          _locationAccess = value;
        });
      }
    } catch (e, stackTrace) {
      // Handle any errors that occur
      print("Error: $e");
      print("Stack trace: $stackTrace");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Settings"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          // Location Access Switch
          _buildSwitchTile(
            title: "Location Access",
            subtitle: "Allow app to access your location",
            value: _locationAccess,
            onChanged: _toggleLocationAccess,
          ),
        ],
      ),
    );
  }

  // Helper method to build a SwitchListTile
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
