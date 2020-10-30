import 'contato.dart';

class Transferencia {
  final double valor;
  final Contato contato;

  Transferencia(
    this.valor,
    this.contato,
  );

  @override
  toString() {
    return 'Transferencia{valor: $valor, contato: $contato}';
  }
}
