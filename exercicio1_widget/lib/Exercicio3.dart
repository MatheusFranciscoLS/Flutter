import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exercicio 3'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            int itemNumber = index + 1;
            return Card(
              child: ListTile(
                title: Text('Item $itemNumber'),
                subtitle: Text('Descrição do Item $itemNumber'),
                leading: Icon(Icons.shopping_cart),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Adicionar ação ao botão de adicionar
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
