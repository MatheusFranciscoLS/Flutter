import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StackExample(),
    );
  }
}

class StackExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Example'),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blue,
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  'Texto Sobreposto',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
