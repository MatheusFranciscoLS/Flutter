import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Configuracoes extends StatefulWidget {
  final String email;

  Configuracoes({required this.email});

  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  bool _darkMode = false;
  int _fontSize = 16;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('${widget.email}_darkMode') ?? false;
      _fontSize = prefs.getInt('${widget.email}_fontSize') ?? 16;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.email}_darkMode', _darkMode);
    await prefs.setInt('${widget.email}_fontSize', _fontSize);
  }

  Future<void> _logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('${widget.email}_darkMode');
      await prefs.remove('${widget.email}_fontSize');
      await prefs.remove('loggedInUserEmail'); // Remove o email do usuário logado
      Navigator.pushReplacementNamed(context, '/login'); // Redireciona para a tela de login
    } catch (e) {
      print('Erro ao realizar logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Modo Escuro'),
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
                _saveSettings();
              },
            ),
            Slider(
              value: _fontSize.toDouble(),
              min: 10,
              max: 30,
              divisions: 4,
              label: 'Tamanho da Fonte: $_fontSize',
              onChanged: (value) {
                setState(() {
                  _fontSize = value.toInt();
                });
                _saveSettings();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logout(); // Chama a função de logout
              },
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
