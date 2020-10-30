import 'package:bytebank/components/mensagem_centralizada.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/http/webclients/transferencias_webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  _ListaTransferenciasState createState() => _ListaTransferenciasState();
}

class _ListaTransferenciasState extends State<ListaTransferencias> {
  final TransferenciasWebclient _webClient = TransferenciasWebclient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: FutureBuilder(
          future: _webClient.findAll(),
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
                if (snapshot.hasData) {
                  final List<Transaction> transferencias = snapshot.data;
                  if (transferencias.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return _TransferenciaItem(transferencias[index]);
                      },
                      itemCount: transferencias.length,
                    );
                  }
                }
                break;
            }
            return MenssagemCentralizada(
              'Nenhuma Transferência encontrada!',
              icone: Icons.warning,
              fontSize: 16,
            );
          }),
    );
  }
}

class _TransferenciaItem extends StatelessWidget {
  final Transaction transferencia;

  _TransferenciaItem(this.transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transferencia.value.toString(),
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          transferencia.contact.accountNumber.toString(),
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
