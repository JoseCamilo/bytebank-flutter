import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      debugPrint(path);
      db.execute(ContatoDao.tableSQL);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
