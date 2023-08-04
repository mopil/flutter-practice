import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/loading_screen.dart';
import 'package:untitled/utils/api_client.dart';

void main() {
  runApp(
    Provider<ApiClient>(
      create: (context) => ApiClient('http://54.180.142.211:8080'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
