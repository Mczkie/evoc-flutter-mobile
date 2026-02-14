import 'package:evocapp/providers/localeProvider.dart';
import 'package:evocapp/screens/loginpage.dart';
import 'package:evocapp/screens/startup.dart';
import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          isLoggedIn ? const MyHomePage(email: '') : const MyStartup(email: ''),
      routes: {
        '/startup': (context) => const MyStartup(email: ''),
        '/homepage': (context) => const MyHomePage(email: ''),
        '/login': (context) => const MyLoginPage(email: ''),
      },
    );
  }
}
