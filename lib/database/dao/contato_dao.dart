import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {
  static const String tableSQL = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numeroConta INTEGER)';
  static const String _tableName = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numeroConta = 'numero_conta';

  Future<int> save(Contact contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contatoMap = _toMap(contato);
    return db.insert(_tableName, contatoMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contatos = _toList(result);
    return contatos;
  }

  Map<String, dynamic> _toMap(Contact contato) {
    final Map<String, dynamic> contatoMap = Map();
    contatoMap[_nome] = contato.name;
    contatoMap[_numeroConta] = contato.accountNumber;
    return contatoMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contatos = List();

    for (Map<String, dynamic> row in result) {
      final Contact contato = Contact(
        row[_id],
        row[_nome],
        row[_numeroConta],
      );
      contatos.add(contato);
    }
    return contatos;
  }
}
