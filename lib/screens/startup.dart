import 'package:evocapp/screens/loginpage.dart';
import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStartup extends StatefulWidget {
  final String email;
  const MyStartup({super.key, required this.email});

  @override
  State<MyStartup> createState() => _MyStartupState();
}

class _MyStartupState extends State<MyStartup> {
  bool _loading = true;
  bool _isLoggedIn = false;
  String _email = '';

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? email = prefs.getString('email');

    setState(() {
      _isLoggedIn = loggedIn;
      _email = email ?? '';
      _loading = false;
    });

    // If already logged in, go to home page
    if (_isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(email: _email),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show onboarding only if not logged in
    return IntroductionScreen(
      resizeToAvoidBottomInset: true,
      globalBackgroundColor: Colors.white10,
      pages: [
        PageViewModel(
          image: Center(
            child: Lottie.asset('images/helloLottie.json', height: 280),
          ),
          title: "Hello! Welcome to Eco Vista",
          body:
              "Eco Vista Olongapo City (EVOC) is an app to improve waste segregation and promote sustainability in Olongapo City..",
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            pageColor: Colors.green,
          ),
        ),
        PageViewModel(
          image: Center(
            child: Lottie.asset(
              'images/whatLottie.json',
              height: 280,
            ),
          ),
          title: "What is Eco Vista?",
          body:
              "Eco Vista is a application that used to track if the waste is a bio or Non-biodegradable.",
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            pageColor: Colors.green,
            bodyTextStyle: TextStyle(fontSize: 19),
          ),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyLoginPage(email: ''),
          ),
        );
      },
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next_outlined,
        color: Colors.white,
      ),
      next: const Icon(
        Icons.arrow_circle_right_sharp,
        color: Colors.white,
      ),
      done: const Text("Done",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: DotsDecorator(
        color: Colors.white,
        size: const Size.square(5.0),
        activeSize: const Size(15.0, 5.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
