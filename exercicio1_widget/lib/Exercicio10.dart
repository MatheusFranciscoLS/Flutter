import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedWidgetExample(),
    );
  }
}

class AnimatedWidgetExample extends StatefulWidget {
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample> {
  double _left = 0;
  Color _color = Colors.blue;

  void _handleTap() {
    setState(() {
      _left = _left == 0 ? 200 : 0; // Muda a posição do widget
      _color = _color == Colors.blue ? Colors.red : Colors.blue; // Muda a cor do widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 10'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(left: _left),
            width: 100,
            height: 100,
            color: _color,
            child: Center(
              child: Text(
                'Clique aqui',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
