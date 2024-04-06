import 'package:sa2_autenticacao_configuracao/Model/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDadosCrud {
  late Database _db;

  static final BancoDadosCrud _instance = BancoDadosCrud._internal();

  factory BancoDadosCrud() {
    return _instance;
  }

  BancoDadosCrud._internal();

  // Abre o banco de dados
  Future<void> abrirBancoDados() async {
    try {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'usuarios_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
          );
        },
        version: 1,
      );
    } catch (e) {
      print('Erro ao abrir o banco de dados: $e');
    }
  }

  // Cadastra um novo usuário
  Future<bool> cadastrarUsuario(User user) async {
    try {
      await _db.insert(
        'usuarios',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
      return false;
    }
  }

  // Busca um usuário pelo e-mail
  Future<User?> buscarUsuario(String email) async {
    try {
      List<Map<String, dynamic>> usuarios = await _db.query(
        'usuarios',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (usuarios.isNotEmpty) {
        return User.fromMap(usuarios.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
      return null;
    }
  }

  // Fecha o banco de dados
  Future<void> fecharBancoDados() async {
    try {
      if (_db.isOpen) {
        await _db.close();
      }
    } catch (e) {
      print('Erro ao fechar o banco de dados: $e');
    }
  }

  // Realiza o login do usuário
  Future<User?> realizarLogin(String email, String senha) async {
    try {
      List<Map<String, dynamic>> usuarios = await _db.query(
        'usuarios',
        where: 'email = ? AND password = ?',
        whereArgs: [email, senha],
      );

      if (usuarios.isNotEmpty) {
        return User.fromMap(usuarios.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao realizar login: $e');
      return null;
    }
  }
}
