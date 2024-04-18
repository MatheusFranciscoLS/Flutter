import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart'; // Importe a tela de login se necessário

class Tarefa {
  String titulo;
  String status;

  Tarefa({required this.titulo, required this.status});
}

class TarefasScreen extends StatefulWidget {
  final String email;

  TarefasScreen({required this.email});

  @override
  State<TarefasScreen> createState() => _TarefasScreenState(email: email);
}

class _TarefasScreenState extends State<TarefasScreen> {
  late SharedPreferences _prefs;
  final String email;
  List<Tarefa> _tarefas = [];
  TextEditingController _tarefaController = TextEditingController();
  String _statusSelecionado = 'Todas';

  _TarefasScreenState({required this.email});

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  // Carrega as preferências do usuário ao iniciar a tela
  Future<void> _carregarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
    _carregarTarefasDasPreferencias();
  }

  // Carrega as tarefas salvas nas preferências
  void _carregarTarefasDasPreferencias() {
    List<String>? tarefas = _prefs.getStringList('${email}_tarefas');
    if (tarefas != null) {
      setState(() {
        _tarefas = tarefas.map((tarefa) {
          List<String> partes = tarefa.split(',');
          return Tarefa(titulo: partes[0], status: partes[1]);
        }).toList();
      });
    }
  }

  // Salva as tarefas nas preferências
  void _salvarTarefasNasPreferencias() {
    List<String> tarefas = _tarefas.map((tarefa) {
      return '${tarefa.titulo},${tarefa.status}';
    }).toList();
    _prefs.setStringList('${email}_tarefas', tarefas);
  }

  // Adiciona uma nova tarefa à lista
  void _adicionarTarefa(String titulo) {
    if (titulo.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira o título da tarefa'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _tarefas.add(Tarefa(titulo: titulo.trim(), status: 'Em andamento'));
      _salvarTarefasNasPreferencias();
    });
    _tarefaController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa adicionada com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Exclui uma tarefa da lista
  void _excluirTarefa(int indice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Deseja realmente excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tarefas.removeAt(indice);
                  _salvarTarefasNasPreferencias();
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  // Atualiza o status de uma tarefa
  void _atualizarStatusTarefa(int indice, String status) {
    setState(() {
      _tarefas[indice].status = status;
      _salvarTarefasNasPreferencias();
    });
  }

  // Retorna uma lista de tarefas filtradas de acordo com o status selecionado
  List<Tarefa> _tarefasFiltradas() {
    if (_statusSelecionado == 'Todas') {
      return _tarefas;
    } else {
      return _tarefas
          .where((tarefa) => tarefa.status == _statusSelecionado)
          .toList();
    }
  }

  // Realiza o logout do usuário
  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logout realizado com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(
                hintText: 'Nova Tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _adicionarTarefa(_tarefaController.text),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _statusSelecionado,
              onChanged: (valor) {
                setState(() {
                  _statusSelecionado = valor!;
                });
              },
              items:
                  <String>['Todas', 'Em andamento', 'Concluída', 'Finalizada']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefasFiltradas().length,
                itemBuilder: (contexto, indice) {
                  final tarefa = _tarefasFiltradas()[indice];
                  return ListTile(
                    title: Text(tarefa.titulo),
                    subtitle: Text(tarefa.status),
                    leading: Icon(
                      tarefa.status == 'Concluída'
                          ? Icons.check_circle
                          : tarefa.status == 'Em andamento'
                              ? Icons.access_time
                              : Icons.error,
                      color: tarefa.status == 'Concluída'
                          ? Colors.green
                          : tarefa.status == 'Em andamento'
                              ? Colors.orange
                              : Colors.red,
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (contexto) => [
                        PopupMenuItem(
                          child: Text('Concluída'),
                          value: 'Concluída',
                        ),
                        PopupMenuItem(
                          child: Text('Em andamento'),
                          value: 'Em andamento',
                        ),
                        PopupMenuItem(
                          child: Text('Finalizada'),
                          value: 'Finalizada',
                        ),
                        PopupMenuItem(
                          child: Text('Apagar'),
                          value: 'Apagar',
                        ),
                      ],
                      onSelected: (valor) {
                        if (valor == 'Apagar') {
                          _excluirTarefa(indice);
                        } else {
                          _atualizarStatusTarefa(indice, valor.toString());
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
