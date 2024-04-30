import 'dart:convert';
import 'dart:io';

import 'package:projeto_json/Model/produto_model.dart';

class ProdutoController {
  List<Produto> _produtos = [];

  List<Produto> get produtos {
    return _produtos;
  }
  //método set
  set produtos(List<Produto> produtos) {
    _produtos = produtos;
  }

//Salvar produtos no Json
  Future<void> salvarJson() async {
    final file = File('produto.json');
    final jsonList = produtos.map((produto) => (produto.toJson())).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  //carregar produtos no Json
  Future<List<Produto>> carregarJson() async {
    try {
      final file = File('produto.json');
      final jsonList = jsonDecode(await file.readAsString());
      _produtos = jsonList.map<Produto>((json) => Produto.fromJson(json));
    } catch (e) {
      _produtos = [];
    }
  }
}
