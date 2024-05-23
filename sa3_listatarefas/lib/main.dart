import 'package:flutter/material.dart';

import 'View/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA3",
      debugShowCheckedModeBanner: false,
      home: LoginScreen()
    );
  }
}