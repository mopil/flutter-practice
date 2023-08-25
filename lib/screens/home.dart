import 'package:flutter/material.dart';

import 'package:untitled/screens/instagram.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    // redirect instagram.dart
    InstagramFeedScreen(),
    Text(
      'Index 2: Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getIcon(String name) => Image.asset("assets/images/$name.png",
      width: 30, height: 30, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    String home = "home";
    String feeds = "feeds";
    String profile = "profile";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("여기는 홈 화면 입니다."),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _getIcon(home),
            label: home,
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: _getIcon(feeds),
            label: feeds,
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: _getIcon(profile),
            label: profile,
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
