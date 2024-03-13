import 'package:flutter/material.dart';

class LayoutResponsivo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercicio 6'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Layout para telas largas
              return LayoutLargo();
            } else {
              // Layout para telas estreitas
              return LayoutEstreito();
            }
          },
        ),
      ),
    );
  }
}

class LayoutLargo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.blue,
      child: Center(
        child: Icon(
          Icons.desktop_mac,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}

class LayoutEstreito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.green,
      child: Center(
        child: Icon(
          Icons.phone_android,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LayoutResponsivo(),
  ));
}
