import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final List<Transferencia> transferencias = List();

  @override
  Widget build(BuildContext context) {
    transferencias.add(Transferencia(0, 1000, Contato(0, 'Jose', 1234)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _TransferenciaItem(transferencias[index]);
        },
        itemCount: transferencias.length,
      ),
    );
  }
}

class _TransferenciaItem extends StatelessWidget {
  final Transferencia transferencia;

  _TransferenciaItem(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transferencia.valor.toString(),
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          transferencia.contato.conta.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        leading: Icon(
          Icons.monetization_on,
        ),
      ),
    );
  }
}
