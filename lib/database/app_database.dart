import 'package:bytebank/models/contato.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      debugPrint(path);
      db.execute('CREATE TABLE contatos('
          'id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'conta INTEGER)');
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future<int> save(Contato contato) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contatoMap = Map();

  contatoMap['nome'] = contato.nome;
  contatoMap['conta'] = contato.conta;
  return db.insert('contatos', contatoMap);
}

Future<List<Contato>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('contatos');
  final List<Contato> contatos = List();

  for (Map<String, dynamic> row in result) {
    final Contato contato = Contato(
      row['id'],
      row['nome'],
      row['conta'],
    );
    contatos.add(contato);
  }
  return contatos;
}
