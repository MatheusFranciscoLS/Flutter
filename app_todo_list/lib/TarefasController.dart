import 'package:flutter_app_todo_list/TarefasModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefasController extends ChangeNotifier{
  //lista de tarefas
  List<Tarefa> _tarefas= [];
  //Getter para acessar a lkista de tarefas
  List <Tarefa> get tarefas => _tarefas;

void adicionarTarefa(String descricao) {
  if (descricao.isNotEmpty) {
    _tarefas.add(Tarefa(descricao, false));
    //Notifica os ouvintes (widgets) sobre a mudança no estado
    notifyListeners();

    
  }
}


  // Método para marcar uma tarefa como concluída com base no índice
  void marcarComoConcluida (int indice){
    if (indice >= 0 && indice < _tarefas.length) {
    _tarefas[indice].concluida = !_tarefas[indice].concluida;
    notifyListeners();
  }
}
      

  //Método para excluir uma tarefa com base do indice
  void excluirTarefa(int indice){
    if (indice >= 0 && indice < _tarefas.length){
      _tarefas.removeAt(indice);
      //Notifica os ouintes sobre a mudança no estado
      notifyListeners();
    }
  }
  

  // Método para obter a data e hora formatada da última tarefa adicionada
  String getDataHoraUltimaTarefaAdicionada() {
    if (_tarefas.isNotEmpty) {
      return DateFormat('dd/MM/yyyy HH:mm').format(_tarefas.last.dataHora);
    } else {
      return '';
    }
  }
}