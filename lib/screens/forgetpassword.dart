import 'package:evocapp/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // For toast messages

void main() {
  runApp(const MyForget());
}

class MyForget extends StatelessWidget {
  const MyForget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _emailController =
      TextEditingController(); // Controller for email input
  bool _isLoading = false; // Loading state for the UI

  // Function to simulate sending a password reset email
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Simulate a password reset process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });

        // Simulate sending a password reset email
        Fluttertoast.showToast(
          msg: "Password reset email sent to ${_emailController.text}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Clear the email field after submission
        _emailController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Subtitle
                      const Text(
                        "Enter your email address to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Email Input Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Reset Password Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : _resetPassword, // Disable button while loading
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Back to Login Link
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyLoginPage(
                                        email: "",
                                      ))); // Go back to the login screen
                        },
                        child: const Text(
                          "Back to Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
