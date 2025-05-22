import 'package:flutter/material.dart';
import 'package:evocapp/screens/forgetpassword.dart';
import 'package:evocapp/screens/home_page.dart';
import 'package:evocapp/screens/signuppage.dart';
import 'package:evocapp/components/logtext.dart';
import 'package:evocapp/components/textfield.dart';
import 'package:evocapp/database/db_helper.dart';
import 'package:evocapp/utils/validators.dart';
import 'package:lottie/lottie.dart';

class MyLoginPage extends StatefulWidget {
  final String email;

  const MyLoginPage({super.key, required this.email});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final DbHelper _dbHelper = DbHelper();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _passwordError;

  Future<void> _login() async {
    final passwordError = PasswordValidator.validate(passwordController.text);
    if (passwordError != null) {
      setState(() {
        _passwordError = passwordError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _passwordError = null;
    });

    final email = emailController.text;
    final password = passwordController.text;

    try {
      final user = await _dbHelper.getUser(email);
      if (user != null && user['password'] == password) {
        await _dbHelper.updatedLoginStatus(email, 1);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(email: email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Lottie.asset(
                            "assets/login.json",
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Login into your account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Welcome! Please enter your details.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 50),
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
                                  hintStyle:
                                      const TextStyle(color: Colors.white70),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Colors.white),
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
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
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
                                  padding:
                                      EdgeInsets.only(top: 8.0, left: 12.0),
                                  child: Text(
                                    'Password must be 8-12 chars with uppercase, lowercase, number, and special char',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => MyForget(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forget Password',
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
                          ),
                          const SizedBox(height: 20),
                          MyLogText(onPressed: _login),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Do you have an account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => MySignUpPage(
                                        email: widget.email,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
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
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
