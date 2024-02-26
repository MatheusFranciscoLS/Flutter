import 'package:app_todolist/MercadoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_todolist/MercadoController.dart';
import 'package:intl/intl.dart';


class ListaMercadoScreen extends StatelessWidget {
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _updateDescricaoController = TextEditingController();
  final TextEditingController _updateTipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: [
          // Ícones para ordenar a lista
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              Provider.of<MercadoController>(context, listen: false)
                  .ordenarPorAlfabetica();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Adiciona o produto quando o usuário pressiona o botão de adicionar
              Provider.of<MercadoController>(context, listen: false)
                  .adicionarProduto(
                      _descricaoController.text, _tipoController.text);
              // Limpa os campos de texto após adicionar o produto
              _descricaoController.clear();
              _tipoController.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Campos de texto para adicionar um novo produto
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Nova Descrição',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _tipoController,
                    decoration: InputDecoration(
                      labelText: 'Novo Tipo',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Adiciona o produto quando o usuário pressiona o botão de adicionar
                    Provider.of<MercadoController>(context, listen: false)
                        .adicionarProduto(
                            _descricaoController.text, _tipoController.text);
                    // Limpa os campos de texto após adicionar o produto
                    _descricaoController.clear();
                    _tipoController.clear();
                  },
                ),
              ],
            ),
          ),
          // Lista de produtos usando um Consumer do Provider para atualização automática
     // Lista de produtos usando um Consumer do Provider para atualização automática
Expanded(
  child: Consumer<MercadoController>(
    builder: (context, controller, _) {
      return ListView.builder(
        itemCount: controller.produtos.length,
        itemBuilder: (context, index) {
          Produtos produto = controller.produtos[index];
          return ListTile(
            title: Text(produto.descricao),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tipo: ${produto.tipo}'),
                Text('Data: ${DateFormat('dd/MM/yyyy HH:mm').format(produto.dataHora)}'),
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
              // Exibe um diálogo para atualizar o produto quando o usuário toca no item da lista
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
                            labelText: 'Novo Tipo',
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
                              _updateTipoController.text);
                          Navigator.of(context).pop();
                        },
                        child: Text('Atualizar'),
                      ),
                    ],
                  );
                },
              );
              // Preenche os campos de texto do diálogo de atualização com os valores do produto selecionado
              _updateDescricaoController.text = produto.descricao;
              _updateTipoController.text = produto.tipo;
            },
          );
        },
      );
    },
  ),
),


        ],
      ),
    );
  }
}
