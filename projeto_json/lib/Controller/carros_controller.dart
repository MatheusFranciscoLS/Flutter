import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Model/carros_model.dart';

class CarrosController {
  List<Carro> carroList = [];

  void addCarro(Carro carro) {
    carroList.add(carro);
  }

  //Salva para o Json
  Future<void> saveCarrosToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    final file = File('$path/carros.json');
    final jsonList = carroList.map((carro) => carro.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  //Buscar do Json
  Future<void> loadCarrosFromFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      final jsonList = jsonDecode(await file.readAsString());
      carroList = jsonList.map<Carro>((json) => Carro.fromJson(json)).toList();
    } catch (e) {
      carroList = [];
    }
  }

  // Upload do json
  Future<void> uploadCarrosfromFile(List<Carro> carros) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      final jsonList = carros.map((carro) => carro.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
    }
  }

  // Deletar do json
  Future<void> deleteCarrosfromFile() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      final file = File('$path/carros.json');
      await file.delete();
    } catch (e) {
      print('Erro ao deletar arquivo: $e');
    }
  }
}
