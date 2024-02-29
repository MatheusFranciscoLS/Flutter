import 'package:app_carros/Controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaListaCarros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior do aplicativo
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      // Corpo principal do aplicativo
      body: Column(
        children: [
          // Lista de tarefas usando um Consumer do Provider para atualização automática
          Expanded(
            child: Consumer<CarroController>(
              builder: (context, model, child) {
                return ListView.builder(
                  itemCount: model.listarCarros.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // Exibição do texto da tarefa
                      title: Text(model.listarCarros[index].modelo),

                      // Exclui a tarefa ao manter pressionado
                      onTap: () {
                        // Chamando o método excluirTarefa do Provider para atualizar o estado
                        //Criar metodo para trocar a tela
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

class TelaDetalheCarro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
