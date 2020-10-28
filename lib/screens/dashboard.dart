import 'package:bytebank/screens/lista_contatos.dart';
import 'package:bytebank/screens/lista_transferencias.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ItemDashboard(
                  'Transferir',
                  Icons.monetization_on,
                  onClick: () => _showListaContatos(context),
                ),
                _ItemDashboard(
                  'Transações',
                  Icons.description,
                  onClick: () => _showListaTransferencias(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void _showListaContatos(BuildContext context) {
  Navigator.of(context).push(
    (MaterialPageRoute(
      builder: (context) => ListaContatos(),
    )),
  );
}

void _showListaTransferencias(BuildContext context) {
  Navigator.of(context).push(
    (MaterialPageRoute(
      builder: (context) => ListaTransferencias(),
    )),
  );
}

class _ItemDashboard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onClick;

  _ItemDashboard(
    this.title,
    this.icon, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: this.onClick,
          child: Container(
            height: 100,
            width: 150,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  this.icon,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  this.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
