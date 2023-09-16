import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/home.dart';
import 'package:untitled/utils/api/api.dart';

import 'models/board_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (ctx) => ApiServerConnector("http://10.0.2.2:8080")),
        ChangeNotifierProvider(create: (ctx) => BoardProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
