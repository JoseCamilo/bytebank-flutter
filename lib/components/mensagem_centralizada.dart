import 'package:flutter/material.dart';

class MenssagemCentralizada extends StatelessWidget {
  final String menssagem;
  final IconData icone;
  final double sizeIcon;
  final double fontSize;

  MenssagemCentralizada(
    this.menssagem, {
    this.icone,
    this.sizeIcon = 64,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            child: Icon(
              icone,
              size: sizeIcon,
            ),
            visible: icone != null,
          ),
          Text(
            menssagem,
            style: TextStyle(
              fontSize: fontSize,
            ),
          )
        ],
      ),
    );
  }
}
