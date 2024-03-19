import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Implemente a ação do item de menu aqui
                print('Item 1 selecionado');
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Implemente a ação do item de menu aqui
                print('Item 2 selecionado');
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                // Implemente a ação do item de menu aqui
                print('Item 3 selecionado');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  // Adicione validações de e-mail, se necessário
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  // Adicione validações de senha, se necessário
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submissão do formulário
                    // Aqui você pode enviar os dados para a API, banco de dados, etc.
                    // Por enquanto, vamos apenas imprimir os dados no console
                    print('Nome: $_name');
                    print('E-mail: $_email');
                    print('Senha: $_password');
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
