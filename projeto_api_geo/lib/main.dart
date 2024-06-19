import 'package:flutter/material.dart';
import 'package:projeto_api_geo/View/favorites_screen.dart';
import 'package:projeto_api_geo/View/search_screen.dart';
import 'View/details_weather_screen.dart';
import 'View/home_screen.dart';
import 'View/history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project API GEO",
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200], // Fundo cinza
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
      ),
      routes: {
        '/search': (context) => const SearchScreen(),
        '/history': (context) => const HistoryScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
