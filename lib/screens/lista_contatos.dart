import 'package:bytebank/screens/form_contatos.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(
                'Fernando',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              subtitle: Text('1000',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => FormContatos(),
                ),
              )
              .then(
                (contato) => debugPrint(contato),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
