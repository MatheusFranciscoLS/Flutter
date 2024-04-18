import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/User.dart'; // Importa o modelo de usuário

class BancoDadosCrud {
  static const String DB_NOME = 'users.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'users'; // Nome da tabela
  static const String
      SCRIPT_CRIACAO_TABELA = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY," +
          "nome TEXT, " +
          "email TEXT, " +
          "senha TEXT)";

  // Método privado para chamar o banco de dados
  Future<Database> _chamarBanco() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            SCRIPT_CRIACAO_TABELA); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

  // Método para criar um novo usuário no banco de dados
  Future<void> create(User user) async {
    try {
      final Database db = await _chamarBanco();
      await db.insert(
          TABLE_NOME, user.toMap()); // Insere o usuário no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para buscar o usuário pelo email e senha
  Future<User?> getUser(String email, String senha) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
              where: 'email = ? AND senha = ?',
              whereArgs: [email, senha]); // Consulta o usuário na tabela

      if (maps.isNotEmpty) {
        return User.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário existe com o email e senha fornecidos
  Future<bool> existsUser(String email, String senha) async {
    bool acessoPermitido = false;
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps =
          await db.query(TABLE_NOME,
              where: 'email = ? AND senha = ?',
              whereArgs: [email, senha]); // Consulta o usuário na tabela

      if (maps.isNotEmpty) {
        acessoPermitido = true;
        return acessoPermitido;
      } else {
        return acessoPermitido;
      }
    } catch (ex) {
      print(ex);
      return acessoPermitido;
    }
  }

  // Método para verificar se um email já está cadastrado no banco de dados
  Future<bool> existsEmail(String email) async {
    try {
      final Database db = await _chamarBanco();
      final List<Map<String, dynamic>> maps = await db.query(
        TABLE_NOME,
        columns: ['id'],
        where: 'email = ?',
        whereArgs: [email],
      ); // Consulta se o email já está cadastrado

      return maps.isNotEmpty; // Retorna true se o email já existe, caso contrário retorna false
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
