import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todolist.dart';

class TodolistController {
  // Atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  // Conectar ao Firebase FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Adicionar tarefa
  Future<void> add(Todolist todolist) async {
    await _firestore.collection('todolist').add(todolist.toMap());
  }

  // Deletar tarefa
  Future<void> delete(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  // Buscar lista de tarefas
  Future<List<Todolist>> fetchList(String userId) async {
    final QuerySnapshot result = await _firestore
        .collection('todolist')
        .where('userId', isEqualTo: userId)
        .get();

    _list = result.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Adiciona o ID do documento ao mapa
      return Todolist.fromMap(data);
    }).toList();

    return _list;
  }
}
