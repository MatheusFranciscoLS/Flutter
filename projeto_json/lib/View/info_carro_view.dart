import 'dart:io';

import 'package:flutter/material.dart';
import '../Model/carros_model.dart';

class CarroInfoPage extends StatelessWidget {
  final Carro info;
  CarroInfoPage({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carro Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(info.foto),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(info.modelo),
            Text(info.marca),
            Text(info.ano.toString()),
            Text(info.cor),
            Text(info.descricao),
            Text(info.valor.toString()),
          ],
        ),
      ),
    );
  }
}
