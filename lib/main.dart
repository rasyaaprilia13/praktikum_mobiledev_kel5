// lib/main.dart

import 'package:flutter/material.dart';
import 'menu.dart'; // Import halaman menu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // Langsung arahkan ke halaman menu
      home: const MenusPage(),
    );
  }
}