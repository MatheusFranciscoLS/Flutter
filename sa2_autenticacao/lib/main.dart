import 'package:flutter/material.dart';
import 'package:sa2_autenticacao_configuracao/View/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define o título da aplicação
      title: "Autenticador",
      // Define o tema da aplicação, com a cor azul como primária
      theme: ThemeData(primarySwatch: Colors.blue),
      // Define a tela inicial da aplicação como a tela de login
      home: LoginScreen(),
    );
  }
}
