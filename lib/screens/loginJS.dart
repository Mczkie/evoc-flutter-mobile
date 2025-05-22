import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = false;

  Future<void> _registerUser() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String username = _usernameController.text;

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          'http://192.168.1.249:5000/api/mobiregister'), // Replace with your Node.js backend URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Success
      final data = json.decode(response.body);
      if (data['success']) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration successful')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration failed')));
      }
    } else {
      // Error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _registerUser,
                    child: Text('Register'),
                  ),
          ],
        ),
      ),
    );
  }
}
