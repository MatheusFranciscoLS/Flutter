import 'package:flutter/material.dart';
import 'package:sa2_autenticacao_configuracao/Controller/DbHelper.dart';
import 'package:sa2_autenticacao_configuracao/Model/Model.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroScreen(),
  ));
}

class CadastroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Center(
        child: CadastroForm(),
      ),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  void cadastrarUsuario() async {
    String name = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;

    User user = User(name: name, email: email, password: password);

    BancoDadosCrud bancoDados = BancoDadosCrud();
    await bancoDados.abrirBancoDados(); // Abre o banco de dados

    bool sucesso = await bancoDados.cadastrarUsuario(user);

    if (sucesso) {
      print('Usuário cadastrado com sucesso!');
      Navigator.pop(context); // Redireciona para a tela de login
    } else {
      print('Erro ao cadastrar usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira seu e-mail';
                }
                // Adicione validação de e-mail aqui se necessário
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Por favor, insira sua senha';
                }
                // Adicione validação de senha aqui se necessário
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Adicione a lógica para cadastrar o usuário aqui
                  cadastrarUsuario();
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
