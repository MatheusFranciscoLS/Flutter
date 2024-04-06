import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importe o pacote de formatação de texto
import 'package:sa2_autenticacao_configuracao/Controller/Controller.dart';
import 'package:sa2_autenticacao_configuracao/Model/Model.dart';
import 'package:sa2_autenticacao_configuracao/View/Cadastro.dart';
import 'package:sa2_autenticacao_configuracao/View/Configuracoes.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool _loading = false; // Adicionado indicador de loading

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
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira seu e-mail';
                } else if (!isValidEmail(value)) {
                  return 'E-mail inválido';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                    RegExp(r'[0-9]')), // Impede números
              ],
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
                return null;
              },
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator() // Indicador de loading
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text;
                        String senha = _senhaController.text;

                        BancoDadosCrud bancoDados = BancoDadosCrud();
                        try {
                          await bancoDados.abrirBancoDados();
                          User? user =
                              await bancoDados.realizarLogin(email, senha);
                          if (user != null) {
                            // Login bem-sucedido
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Configuracoes(email: user.email)),
                            );
                          } else {
                            // Login falhou
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email ou senha incorretos'),
                            ));
                          }
                        } catch (e) {
                          print('Erro durante o login: $e');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Erro durante o login. Tente novamente mais tarde.'),
                          ));
                        } finally {
                          await bancoDados.fecharBancoDados();
                        }
                      }
                    },
                    child: Text('Acessar'),
                  ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
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
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
