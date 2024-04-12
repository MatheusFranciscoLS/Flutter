import 'package:flutter/material.dart';
import 'package:sa2_autenticacao_configuracao/View/Configuracoes.dart';
import 'package:sa2_autenticacao_configuracao/View/Login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/configuracoes',  // Rota inicial
    routes: {
      '/configuracoes': (context) => Configuracoes(email: ''),
      '/login': (context) => LoginScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define o título da aplicação
      title: "Autentificação e Configuração",
      // Define o tema da aplicação, com a cor azul como primária
      theme: ThemeData(primarySwatch: Colors.blue),
      // Define a tela inicial da aplicação como a tela de login
      home: LoginScreen(),
    );
  }
}