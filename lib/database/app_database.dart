import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contato('
          'id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'conta INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Contato contato) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contatoMap = Map();
    contatoMap['nome'] = contato.nome;
    contatoMap['conta'] = contato.conta;
    return db.insert('contatos', contatoMap);
  });
}

Future<List<Contato>> findAll() {
  return createDatabase().then((db) {
    return db.query('contatos').then((maps) {
      final List<Contato> contatos = List();
      for (Map<String, dynamic> map in maps) {
        final Contato contato = Contato(
          map['id'],
          map['nome'],
          map['conta'],
        );
        contatos.add(contato);
      }
      return contatos;
    });
  });
}
