import 'package:app_carros/Model.dart';

class CarroController {
  //Atributo
  List<Carro> _carrosLista = [
    Carro("Fiat Uno",1992,"caminho da imagem"),
    Carro("Classic",2012,"caminho da imagem")];

  //métodos
  List<Carro> get listarCarros => _carrosLista;

  //outros métodos
  void adicionarCarro(String modelo, int ano, String imagemUrl){
    Carro carro = Carro(modelo, ano, imagemUrl);
    _carrosLista.add(carro);
  }
}
