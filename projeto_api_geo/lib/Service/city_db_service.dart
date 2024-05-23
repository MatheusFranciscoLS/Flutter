import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/city_model.dart';

class CityDataBaseService {
  static const String DB_NOME = 'cities.db'; // Nome do banco de dados
  static const String TABLE_NOME = 'cities'; // Nome da tabela
  static const String
      CREATE_CONTACTS_TABLE_SCRIPT = // Script SQL para criar a tabela
      """CREATE TABLE cities(
        id SERIAL, 
        cityname TEXT, 
        favoritecities BOOLEAN DEFAULT false)""";

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NOME), // Caminho do banco de dados
      onCreate: (db, version) {
        return db.execute(
            CREATE_CONTACTS_TABLE_SCRIPT); // Executa o script de criação da tabela quando o banco é criado
      },
      version: 1,
    );
  }

  Future<List<City>> getAllCities() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> maps = await db.query(TABLE_NOME);
    return List.generate(
      maps.length,
      (i) {
        return City.fromMap(
            maps[i]); // Converte os resultados da consulta para objetos City
      },
    );
  }

  Future<int> insertCity(City city) async {
    Database db = await _getDatabase();
    return await db.insert(TABLE_NOME, city.toMap());
  }
  
}
