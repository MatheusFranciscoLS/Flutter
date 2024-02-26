import 'package:app_todolist/MercadoController.dart';
import 'package:app_todolist/MercadoView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MercadoApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      //Definindo a tela inicial como TarefasScreen
      home: ChangeNotifierProvider(create: (context) => MercadoController(),
      child: ListaMercadoScreen(),
    ),
    );
  }

}