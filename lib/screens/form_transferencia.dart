import 'dart:async';

import 'package:bytebank/components/dialog_auth_transaction.dart';
import 'package:bytebank/components/progresso.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/http/webclients/transferencias_webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FormTransferencia extends StatefulWidget {
  final Contact contact;

  FormTransferencia(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<FormTransferencia> {
  final TextEditingController _valueController = TextEditingController();
  final TransferenciasWebclient _webClient = TransferenciasWebclient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Progresso(
                  message: 'Enviando...',
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return DialogAuthTransaction(
                              onConfirm: (password) {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction =
        await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(
        context,
        message: e.message,
      );
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(
        context,
        message: 'Falha na conexão, tente novamente mais tarde',
      );
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });

    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transferência realizada');
          });
      Navigator.pop(context);
    }
  }

  void _showFailureMessage(
    BuildContext context, {
    String message = 'Erro desconhecido',
  }) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
