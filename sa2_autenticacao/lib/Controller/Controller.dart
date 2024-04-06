import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDadosCrud {
  static const String DB_NOME = 'contacts.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'contacts'; // Nome da tabela

  static const String
      CREATE_CONTACTS_TABLE_SCRIPT = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS $TABLE_NOME("
      "email TEXT PRIMARY KEY,"
      "nome TEXT,"
      "senha TEXT)";

  // Abre o banco de dados
  Future<Database> abrirBancoDados() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  // Cadastra um novo usuário
  Future<void> cadastrarUsuario(String nome, String email, String senha) async {
    final db = await abrirBancoDados();
    await db.insert(
      TABLE_NOME,
      {
        'nome': nome,
        'email': email,
        'senha': senha,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Busca um usuário pelo e-mail
  Future<Map<String, dynamic>?> buscarUsuario(String email) async {
    final db = await abrirBancoDados();
    List<Map<String, dynamic>> results = await db.query(TABLE_NOME,
        where: "email = ?", whereArgs: [email], limit: 1);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
  

}
