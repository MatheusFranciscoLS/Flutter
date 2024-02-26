import 'package:flutter/material.dart';
import 'package:flutter_app_todo_list/TarefasController.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TarefasScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Consumer<TarefasController>(
        builder: (context, model, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Nova Tarefa',
                    suffixIcon: IconButton(
                      onPressed: () {
                        Provider.of<TarefasController>(context, listen: false)
                            .adicionarTarefa(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.tarefas.length,
                  itemBuilder: (context, index) {
                    var tarefa = model.tarefas[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text('${tarefa.descricao} - ${DateFormat('dd/MM/yyyy HH:mm').format(tarefa.dataHora)}'),
                          trailing: Checkbox(
                            value: tarefa.concluida,
                            onChanged: (value) {
                              model.marcarComoConcluida(index);
                            },
                          ),
                          onLongPress: () {
                            model.excluirTarefa(index);
                          },
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
