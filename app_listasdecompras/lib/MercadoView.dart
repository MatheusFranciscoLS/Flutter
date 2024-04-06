import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'MercadoController.dart';
import 'MercadoModel.dart';

class ListaMercadoScreen extends StatelessWidget {
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _updateDescricaoController = TextEditingController();
  final TextEditingController _updateTipoController = TextEditingController();

void _adicionarProduto(BuildContext context) {
  String descricao = _descricaoController.text.trim();
  String tipo = _tipoController.text.trim();

  if (descricao.isNotEmpty && tipo.isNotEmpty) {
    bool produtoExistente = Provider.of<MercadoController>(context, listen: false)
        .produtos
        .any((produto) => produto.descricao == descricao);
    if (!produtoExistente) {;
      Provider.of<MercadoController>(context, listen: false)
          .adicionarProduto(descricao, tipo);
      _descricaoController.clear();
      _tipoController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Descrição já existe'),
          content: Text('A descrição "$descricao" já foi adicionada à lista.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Campos vazios'),
        content: Text('Por favor, preencha todos os campos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              Provider.of<MercadoController>(context, listen: false).ordenarPorAlfabetica();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarProduto(context),
        tooltip: 'Adicionar Produto',
        child: Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
              onSubmitted: (_) => _adicionarProduto(context),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(
                labelText: 'Categoria',
              ),
              onSubmitted: (_) => _adicionarProduto(context),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Consumer<MercadoController>(
                builder: (context, controller, _) {
                  return ListView.builder(
                    itemCount: controller.produtos.length,
                    itemBuilder: (context, index) {
                      Produtos produto = controller.produtos[index];
                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            produto.descricao,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tipo: ${produto.tipo}'),
                              Text(
                                'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(produto.dataHora)}',
                                style: TextStyle(fontSize: 12.0, color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Excluir Produto'),
                                        content: Text('Tem certeza de que deseja excluir este produto?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.excluirProduto(index);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Excluir'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              Checkbox(
                                value: produto.concluida,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (value) {
                                      controller.marcarComoConcluida(index);
                                    } else {
                                      controller.desmarcarComoConcluida(index);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Atualizar Produto'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _updateDescricaoController,
                                        decoration: InputDecoration(
                                          labelText: 'Nova Descrição',
                                        ),
                                      ),
                                      TextField(
                                        controller: _updateTipoController,
                                        decoration: InputDecoration(
                                          labelText: 'Nova Categoria',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.atualizarProduto(
                                          index,
                                          _updateDescricaoController.text,
                                          _updateTipoController.text,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Atualizar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            _updateDescricaoController.text = produto.descricao;
                            _updateTipoController.text = produto.tipo;
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
