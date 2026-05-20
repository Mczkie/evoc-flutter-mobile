import 'package:evocapp/menu.dart';
import 'package:evocapp/screens/scanner.dart';
import 'package:evocapp/screens/user_screen/studentpages/studenthome.dart';
import 'package:evocapp/screens/user_screen/studentpages/tips/tips.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  int _currentIndex = 0;
  late Future<List<Widget>> _bodyFuture;

  @override
  void initState() {
    super.initState();
    _bodyFuture = _initializeBody();
  }

  Future<List<Widget>> _initializeBody() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate async work
    return [
      Studenthome(),
      MyScanner(),
      MyTips(),
      MyMenu(email: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black26,
          enableFeedback: false,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tips_and_updates),
              label: 'Tips',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ]),
    );
  }
}
