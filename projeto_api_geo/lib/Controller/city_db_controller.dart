import 'package:projeto_api_geo/Model/city_model.dart';
import 'package:projeto_api_geo/Service/city_db_service.dart';

class CityDbController {
  // Atributos
  List<City> _cities = [];
  final CityDataBaseService _dbService = CityDataBaseService();

  // Getter para a lista de cidades
  List<City> get cities => _cities;

  // Método para listar todas as cidades
  Future<List<City>> listCities() async {
    try {
      List<Map<String, dynamic>> maps = await _dbService.getAllCities();
      _cities = maps.map((e) => City.fromMap(e)).toList();
      return _cities;
    } catch (e) {
      // Tratar exceção, lançar ou logar erro, conforme necessário
      print('Erro ao listar cidades: $e');
      return []; // Retorna uma lista vazia em caso de erro
    }
  }

  // Método para adicionar uma nova cidade
  Future<void> addCity(City city) async {
    try {
      await _dbService.insertCity(city);
      _cities.add(city); // Adiciona à lista local após inserção bem sucedida
    } catch (e) {
      // Tratar exceção, lançar ou logar erro, conforme necessário
      print('Erro ao adicionar cidade: $e');
    }
  }
}
