import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contexto) {
    return MaterialApp(
      home: FormularioContato(),
    );
  }
}

class FormularioContato extends StatefulWidget {
  @override
  _FormularioContatoEstado createState() => _FormularioContatoEstado();
}

class _FormularioContatoEstado extends State<FormularioContato> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext contexto) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (valor) {
                  if (valor!.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (valor) {
                  if (valor!.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mensagemController,
                decoration: InputDecoration(
                  labelText: 'Mensagem',
                ),
                validator: (valor) {
                  if (valor!.isEmpty) {
                    return 'Por favor, insira uma mensagem';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Processar os dados do formulário
                      String nome = _nomeController.text;
                      String email = _emailController.text;
                      String mensagem = _mensagemController.text;
                      // Aqui você pode enviar os dados para algum serviço, armazenar localmente, etc.
                      // Por enquanto, apenas exibimos um diálogo com os dados enviados
                      showDialog(
                        context: contexto,
                        builder: (BuildContext contexto) {
                          return AlertDialog(
                            title: Text('Dados do Formulário'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Nome: $nome'),
                                Text('E-mail: $email'),
                                Text('Mensagem: $mensagem'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(contexto).pop();
                                },
                                child: Text('Fechar'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
