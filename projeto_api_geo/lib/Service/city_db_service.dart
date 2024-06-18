// city_db_service.dart

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/city_model.dart';

class CityDataBaseService {
  static const String DB_NAME = 'cities.db';
  static const String TABLE_NAME = 'cities';
  static const String CREATE_TABLE_SCRIPT = """
    CREATE TABLE cities( 
      cityname TEXT PRIMARY KEY, 
      favoritecities INTEGER)
    """;

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getAllCities() async {
    try {
      Database db = await _getDatabase();
      List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
      await db.close();
      return maps;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> insertCity(City city) async {
    try {
      Database db = await _getDatabase();
      await db.insert(TABLE_NAME, city.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      await db.close();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCity(String cityName) async {
    try {
      Database db = await _getDatabase();
      await db.delete(TABLE_NAME, where: 'cityname = ?', whereArgs: [cityName]);
      await db.close();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isCityFavorite(String cityName) async {
    try {
      Database db = await _getDatabase();
      List<Map<String, dynamic>> maps = await db.query(
        TABLE_NAME,
        where: 'cityname = ? AND favoritecities = 1',
        whereArgs: [cityName],
      );
      await db.close();
      return maps.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
