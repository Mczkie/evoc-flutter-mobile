import 'package:flutter/material.dart';
import 'package:evocapp/components/signupbutton.dart';
import 'package:evocapp/components/textfield.dart';
import 'package:evocapp/screens/loginpage.dart';
import 'package:evocapp/database/db_helper.dart';
import 'package:evocapp/utils/validators.dart';
import 'package:lottie/lottie.dart';

class MySignUpPage extends StatefulWidget {
  final String email;
  const MySignUpPage({super.key, required this.email});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final DbHelper _dbHelper = DbHelper();

  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _passwordError;

  Future<void> _register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate password first
    final passwordError = PasswordValidator.validate(password);
    if (passwordError != null) {
      setState(() {
        _passwordError = passwordError;
      });
      return;
    }

    if (name.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Name and Email are required fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _passwordError = null;
    });

    try {
      await _dbHelper.insertUser(name, email, password);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('User registration successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyLoginPage(email: email),
                  ),
                );
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering user: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/signup.json",
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your details to create an account.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obsecureText: false,
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obsecureText: false,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          errorText: _passwordError,
                        ),
                        onChanged: (value) {
                          if (_passwordError != null) {
                            setState(() {
                              _passwordError = null;
                            });
                          }
                        },
                      ),
                      if (_passwordError == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 12.0),
                          child: Text(
                            'Password must be 8-12 chars with:\n- Uppercase letter\n- Lowercase letter\n- Number\n- Special character',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MySignup(onPressed: _register),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyLoginPage(
                                email: widget.email,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
