import 'package:flutter/material.dart';
import 'screen/cadastrar_produto_screen.dart';
import 'screen/listar_produtos_screen.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto APIRest JSON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/listar': (context) => const ListarProdutosScreen(),
        '/cadastrar': (context) => const CadastrarProdutoScreen(),
        // '/buscar': (context) => const BuscarProdutoScreen(), //verificar se o produto existe atraves do ID
        // 'editar': (context) => const EditarProdutoScreen(), //verificar se o ID existe , se existir atualize o mesmo
        // 'delete': (context) => const DeletarProdutoScreen() //verificar se o ID existe , se existir delete o mesmo
      },
    );
  }
}
