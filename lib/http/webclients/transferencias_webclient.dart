import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransferenciasWebclient {
  static const String _baseURL = 'http://192.168.137.1:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(_baseURL).timeout(Duration(seconds: 15));
    final List<dynamic> bodyJson = jsonDecode(response.body);
    return bodyJson.map((el) => Transaction.fromJson(el)).toList();
  }

  Future<dynamic> save(Transaction transferencia, String password) async {
    final String body = jsonEncode(transferencia.toJson());
    final Response response = await client
        .post(
          _baseURL,
          headers: {
            'Content-type': 'application/json',
            'password': password,
          },
          body: body,
        )
        .timeout(Duration(seconds: 15));

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
