import 'package:bytebank/components/mensagem_centralizada.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/form_contatos.dart';
import 'package:bytebank/screens/form_transferencia.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final ContatoDao _dao = ContatoDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: FutureBuilder(
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progresso();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contato = contatos[index];
                  return _ContatoItem(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FormTransferencia(contato)));
                    },
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }

          return MenssagemCentralizada(
            'Erro ao carregar dados!',
            icone: Icons.warning,
            fontSize: 16,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => FormContatos(),
                ),
              )
              .then((value) => {
                    setState(() {
                      widget.createState();
                    })
                  });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContatoItem extends StatelessWidget {
  final Contact contato;
  final Function onClick;

  _ContatoItem(
    this.contato, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(
          contato.name,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contato.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
