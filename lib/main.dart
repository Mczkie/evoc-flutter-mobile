import 'package:evocapp/providers/localeProvider.dart';
import 'package:evocapp/screens/loginpage.dart';
import 'package:evocapp/screens/startup.dart';
import 'package:evocapp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            return const MyHomePage(email: '');
          } else {
            return const MyLoginPage(email: '');
          }
        },
      ),
      routes: {
        '/homepage': (context) => const MyHomePage(email: ''),
        '/login': (context) => const MyLoginPage(email: ''),
        '/startup': (context) => const MyStartup(email: ''),
      },
    );
  }
}
