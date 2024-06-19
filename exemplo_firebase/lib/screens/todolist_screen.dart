import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controller/todolist_controller.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service = AuthService();
  final TodolistController _controller = TodolistController();
  final _tituloController = TextEditingController();
  late Future<void> _futureList;

  @override
  void initState() {
    super.initState();
    _futureList = _getList();
  }

  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
      setState(() {}); // Atualizar o estado após buscar a lista
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List Firebase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Chamar o logout
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: FutureBuilder<void>(
            future: _futureList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (_controller.list.isEmpty) {
                return const Text('Nenhuma tarefa encontrada');
              } else {
                return ListView.builder(
                  itemCount: _controller.list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_controller.list[index].titulo),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _controller.delete(_controller.list[index].id);
                          setState(() {
                            _futureList = _getList();
                          });
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text("Salvar"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Todolist add = Todolist(
                        id: '', // Deixe o Firestore gerar o ID
                        titulo: _tituloController.text,
                        userId: widget.user.uid,
                        timestamp: Timestamp.now(), // Usa Timestamp em vez de DateTime
                      );
                      await _controller.add(add);
                      _tituloController.clear();
                      setState(() {
                        _futureList = _getList();
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
