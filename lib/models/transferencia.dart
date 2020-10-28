import 'contato.dart';

class Transferencia {
  final int id;
  final double valor;
  final Contato contato;

  Transferencia(
    this.id,
    this.valor,
    this.contato,
  );

  @override
  toString() {
    return 'Transferencia{id: $id, valor: $valor, contato: $contato}';
  }
}
