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
  void exibirMensagem(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mensagem),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 7'),
      ),
      body: Center(
        child: Text('Conteúdo da página'),
      ),
      drawer: Builder(
        builder: (context) => Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Exibir Mensagem'),
                onTap: () {
                  exibirMensagem(context, 'Mensagem exibida!');
                  Navigator.pop(context); // Fecha o Drawer
                },
              ),
              ListTile(
                title: Text('Navegar para Nova Tela'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NovaTela()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NovaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Tela'),
      ),
      body: Center(
        child: Text('Conteúdo da nova tela'),
      ),
    );
  }
}
