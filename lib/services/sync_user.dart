import 'package:evocapp/database/db_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Fetch all users from SQLite and send to the backend
Future<void> syncUsers() async {
  try {
    // Get the users from your local SQLite database (using DbHelper)
    List<Map<String, dynamic>> users = await DbHelper().getUsers();

    // Ensure that users are in a correct format
    if (users.isEmpty) {
      print("No users to sync.");
      return; // Early return if no users are available
    }

    // Send users to your backend
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/sync-users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(users), // Send user data as JSON
    );

    if (response.statusCode == 200) {
      print("Users synced successfully");
    } else {
      print("Failed to sync users, status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error syncing users: $e");
  }
}
