import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Número de abas
        child: Scaffold(
          appBar: AppBar(
            title: Text('Exercicio 4'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Início'),
                Tab(icon: Icon(Icons.shopping_cart), text: 'Compras'),
                Tab(icon: Icon(Icons.settings), text: 'Configurações'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Conteúdo da aba 'Início'
              Center(child: Text('Página Inicial')),
              // Conteúdo da aba 'Compras'
              Center(child: Text('Página de Compras')),
              // Conteúdo da aba 'Configurações'
              Center(child: Text('Página de Configurações')),
            ],
          ),
        ),
      ),
    );
  }
}
