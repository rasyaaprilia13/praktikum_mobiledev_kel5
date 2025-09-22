// lib/main.dart
import 'package:flutter/material.dart';
import 'loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hilangkan banner debug
      title: 'Simple Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // langsung ke LoginPage
    );
  }
}
