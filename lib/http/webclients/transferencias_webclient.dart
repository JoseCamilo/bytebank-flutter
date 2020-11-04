import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransferenciasWebclient {
  static const String _baseURL = 'http://192.168.137.1:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(_baseURL);
    final List<dynamic> bodyJson = jsonDecode(response.body);
    return bodyJson.map((el) => Transaction.fromJson(el)).toList();
  }

  Future<dynamic> save(Transaction transferencia, String password) async {
    final String body = jsonEncode(transferencia.toJson());
    await Future.delayed(Duration(seconds: 10));
    final Response response = await client.post(
      _baseURL,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessageException(response.statusCode));
  }

  String _getMessageException(int statusCode) {
    if (_StatusCodeResponseMap.containsKey(statusCode)) {
      return _StatusCodeResponseMap[statusCode];
    }
    return 'Erro inesperado';
  }

  static const Map<int, String> _StatusCodeResponseMap = {
    400: 'Valor de transferência em branco',
    401: 'Falha de autenticação'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
