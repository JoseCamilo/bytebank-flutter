import 'package:flutter/material.dart';

class DialogAuthTransaction extends StatefulWidget {
  final Function(String password) onConfirm;

  DialogAuthTransaction({@required this.onConfirm});

  @override
  _DialogAuthTransactionState createState() => _DialogAuthTransactionState();
}

class _DialogAuthTransactionState extends State<DialogAuthTransaction> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
          controller: _passwordController,
          decoration: InputDecoration(border: OutlineInputBorder()),
          obscureText: true,
          maxLength: 4,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 56,
            letterSpacing: 24,
          )),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onConfirm(_passwordController.text);
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
