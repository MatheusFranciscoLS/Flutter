import 'package:flutter/material.dart';
import 'package:flutter_app_todo_list/TarefasController.dart';
import 'package:flutter_app_todo_list/TarefasView.dart';
import 'package:provider/provider.dart';

class TarefasApp extends StatelessWidget {
  @override
Widget build (BuildContext context){
  return MaterialApp(
// Defenindo a tela inicial como a tarefa
home: ChangeNotifierProvider
(create: (context) => TarefasController(),
child: TarefasScreen(),)
  );
}

}