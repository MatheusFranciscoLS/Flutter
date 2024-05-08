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
            Text('Placa: ${info.placa}'),
            Text('Modelo: ${info.placa}'),
            Text('Marca: ${info.placa}'),
            Text('Ano: ${info.placa.toString()}'),
            Text('Cor: ${info.cor}'),
            Text('Descrição: ${info.descricao}'),
            Text('Valor: ${info.valor.toString()}'),
          ],
        ),
      ),
    );
  }
}
