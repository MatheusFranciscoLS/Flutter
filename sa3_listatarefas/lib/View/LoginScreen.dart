import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Controller/BancoDados.dart'; // Importa o controlador do banco de dados
import '../Model/User.dart'; // Importa o modelo de usuário
import 'CadastroScreen.dart'; // Importa a tela de cadastro
import 'TarefasScreen.dart'; // Importa a tela de tarefas

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginForm(), // Mostra o formulário de login
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Chave para o formulário
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _loading = false; // Variável para controlar o estado de carregamento
  bool _showPassword = false; // Variável para mostrar/esconder a senha

  // Função para realizar o login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true; // Define o estado de carregamento como verdadeiro
      });

      BancoDadosCrud bancoDados = BancoDadosCrud();
      try {
        User? user = await bancoDados.getUser(email, senha);
        if (user != null) {
          // Se o usuário existir, navega para a tela de tarefas
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login realizado com sucesso'),
            duration: Duration(seconds: 1),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TarefasScreen(email: user.email),
            ),
          );
        } else {
          // Se o usuário não existir, exibe uma mensagem de erro
          _showSnackBar('Email ou senha incorretos');
        }
      } catch (e) {
        print('Erro durante o login: $e');
        _showSnackBar('Erro durante o login. Tente novamente mais tarde.');
      } finally {
        setState(() {
          _loading = false; // Define o estado de carregamento como falso
        });
      }
    }
  }

  // Função para mostrar uma snackbar com uma mensagem
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
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
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!isValidEmail(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator() // Mostra um indicador de carregamento se estiver carregando
                  : ElevatedButton(
                      onPressed: _loading
                          ? null
                          : _login, // Desabilita o botão se estiver carregando
                      child: _loading ? Text('Carregando...') : Text('Acessar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navega para a tela de cadastro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()),
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para validar o e-mail
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
