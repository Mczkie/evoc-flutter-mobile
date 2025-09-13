import 'package:evocapp/menu.dart';
import 'package:evocapp/screens/home.dart';
// import 'package:evocapp/screens/loginpage.dart';
import 'package:evocapp/screens/announcement.dart';
import 'package:evocapp/screens/tips.dart';
import 'package:evocapp/screens/scanner.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String email;

  const MyHomePage({super.key, required this.email});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late Future<List<Widget>> _bodyFuture;

  @override
  void initState() {
    super.initState();
    _bodyFuture = _initializeBody();
  }

  Future<List<Widget>> _initializeBody() async {
    // Initialize your widgets here
    await Future.delayed(const Duration(seconds: 1)); // Simulate async work
    return [
      MyHome(email: widget.email),
      const MyTips(),
      const MyAnnouncement(),
      MyMenu(
        email: widget.email,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: FutureBuilder<List<Widget>>(
        future: _bodyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: snapshot.data![_currentIndex],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(
                          height: 8.0), // Space above the ElevatedButton
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyScanner(),
                            ),
                          );
                        },
                        child: const Text('Camera'),
                      ),
                      const SizedBox(
                          height:
                              8.0), // Space between ElevatedButton and BottomNavigationBar
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates, color: Colors.black),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement, color: Colors.black),
            label: 'Anouncement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded, color: Colors.black),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
