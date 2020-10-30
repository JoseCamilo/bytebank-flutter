import 'dart:convert';

import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

Future<List<Transferencia>> findAllTransferencias() async {
  final Response response = await get('http://192.168.137.1:8080/transactions')
      .timeout(Duration(seconds: 15));
  final List<dynamic> jsonObj = jsonDecode(response.body);
  final List<Transferencia> transferencias = List();

  for (Map<String, dynamic> element in jsonObj) {
    final Map<String, dynamic> contato = element['contact'];
    final Transferencia transferencia = Transferencia(
        element['value'],
        Contato(
          0,
          contato['name'],
          contato['accountNumber'],
        ));
    transferencias.add(transferencia);
  }
  return transferencias;
}
