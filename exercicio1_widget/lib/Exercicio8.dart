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
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 8'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          CardProduto(
            imagemUrl: 'https://via.placeholder.com/150',
            titulo: 'Produto 1',
            descricao: 'Descrição do Produto 1',
          ),
          CardProduto(
            imagemUrl: 'https://via.placeholder.com/150',
            titulo: 'Produto 2',
            descricao: 'Descrição do Produto 2',
          ),
          CardProduto(
            imagemUrl: 'https://via.placeholder.com/150',
            titulo: 'Produto 3',
            descricao: 'Descrição do Produto 3',
          ),
        ],
      ),
    );
  }
}

class CardProduto extends StatelessWidget {
  final String imagemUrl;
  final String titulo;
  final String descricao;

  CardProduto({required this.imagemUrl, required this.titulo, required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(
            imagemUrl,
            fit: BoxFit.cover,
            height: 200.0,
          ),
          ListTile(
            title: Text(titulo),
            subtitle: Text(descricao),
          ),
        ],
      ),
    );
  }
}
