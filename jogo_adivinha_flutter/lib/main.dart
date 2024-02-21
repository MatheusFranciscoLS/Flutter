import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio da Adivinhação',
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  // atributos
  TextEditingController _controllerNumero1 = TextEditingController();
  String _resultado = '';
  int numeroSorteado = Random().nextInt(100) + 1;
  int _tentativas = 0;
  bool _acertou = false;
  List<int> _historico = [];

  // método
  void _adivinhar() {
    int numero = int.tryParse(_controllerNumero1.text) ?? 0;

    setState(() {
      _tentativas++;
      _historico.add(numero);
      if (numero == numeroSorteado) {
        _resultado = "🎉 Parabéns, você acertou em $_tentativas tentativas!";
        _acertou = true;
      } else if (numero < numeroSorteado) {
        _resultado = "Tente um Nº Maior";
      } else if (numero > numeroSorteado) {
        _resultado = "Tente um Nº Menor";
      } else {
        _resultado = "Por favor, insira um número válido.";
      }
    });
  }

  void _reiniciarJogo() {
    setState(() {
      numeroSorteado = Random().nextInt(100) + 1;
      _tentativas = 0;
      _resultado = '';
      _acertou = false;
      _historico.clear();
    });
  }

  void _desistir() {
    setState(() {
      _resultado = "Você desistiu. O número era $numeroSorteado.";
      _acertou = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafio da Adivinhação'),
        centerTitle: true,
        leading: Icon(Icons.games),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: !_acertou,
              child: Column(
                children: [
                  TextField(
                    controller: _controllerNumero1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Digite um número'),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () => _adivinhar(),
                    child: Text('Adivinhar'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () => _desistir(),
                    child: Text('Desistir'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60.0),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _acertou,
              child: ElevatedButton(
                onPressed: () => _reiniciarJogo(),
                child: Text('Jogar Novamente'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 60.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _resultado,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            if (_historico.isNotEmpty)
              Text(
                'Tentativas anteriores: ${_historico.join(", ")}',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            Text(
              'Tentativas: $_tentativas',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
