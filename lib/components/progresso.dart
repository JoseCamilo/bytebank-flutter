import 'package:flutter/material.dart';

class Progresso extends StatelessWidget {
  final String message;
  final double fontSize;

  Progresso({this.message = 'Carregando...', this.fontSize = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: CircularProgressIndicator(
              strokeWidth: 8,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
