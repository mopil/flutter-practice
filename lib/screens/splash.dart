import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlutterLogo(size: 100.0),
            SizedBox(height: 50.0),
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text("로딩 중...")
          ],
        ),
      ),
    );
  }
}
