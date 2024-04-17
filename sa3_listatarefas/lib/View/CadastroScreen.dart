import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Controller/BancoDados.dart';
import '../Model/User.dart';

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
  TextEditingController _confirmarSenhaController = TextEditingController();
  bool _showPassword = false;

  void cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;
    String confirmPassword = _confirmarSenhaController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não coincidem')),
      );
      return;
    }

    BancoDadosCrud bancoDados = BancoDadosCrud();

    bool emailExists = await bancoDados.existsEmail(email);

    if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail já cadastrado!')),
      );
      return;
    }

    User user = User(nome: name, email: email, senha: password);

    try {
      bancoDados.create(user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
      _formKey.currentState?.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                decoration: InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira seu nome';
                  }
                  if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                    return 'Nome inválido, por favor insira somente letras';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value!)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Por favor, confirme sua senha';
                  } else if (value != _senhaController.text) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cadastrarUsuario(context);
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

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

