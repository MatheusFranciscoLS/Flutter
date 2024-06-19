import 'package:flutter/material.dart';

import 'screen/home_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Player',
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.orange,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      home: const HomeScreen(),
       debugShowCheckedModeBanner: false, // Adicione esta linha
    );
  }
}

