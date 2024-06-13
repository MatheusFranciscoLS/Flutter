import 'package:cloud_firestore/cloud_firestore.dart';

class Todolist {
  String id;
  String titulo;
  String userId;
  Timestamp timestamp;

  Todolist({
    required this.id,
    required this.titulo,
    required this.userId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'userId': userId,
      'timestamp': timestamp,
    };
  }

  // Método fromMap que utiliza o ID do documento
  factory Todolist.fromMap(Map<String, dynamic> map) {
    return Todolist(
      id: map['id'],
      titulo: map['titulo'],
      userId: map['userId'],
      timestamp: map['timestamp'],
    );
  }
}