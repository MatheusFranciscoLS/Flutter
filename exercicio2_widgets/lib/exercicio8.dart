import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageExample(),
    );
  }
}

class ImageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibindo imagem de uma URL externa
            Image.network(
              'https://stcotvfoco.com.br/2023/12/bandeira-do-sao-paulo-2.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // Exibindo imagem de um recurso local
            Image.asset(
              'assets/nike.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
