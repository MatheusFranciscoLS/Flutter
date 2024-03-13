import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Exercicio 9'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Conteúdo da Tab 1
            Center(child: Text('Conteúdo da Tab 1')),
            // Conteúdo da Tab 2
            Center(child: Text('Conteúdo da Tab 2')),
            // Conteúdo da Tab 3
            Center(child: Text('Conteúdo da Tab 3')),
          ],
        ),
      ),
    );
  }
}
