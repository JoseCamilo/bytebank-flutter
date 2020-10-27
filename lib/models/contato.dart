class Contato {
  final int id;
  final String nome;
  final int conta;

  Contato(
    this.id,
    this.nome,
    this.conta,
  );

  @override
  toString() {
    return 'Contato{id: $id, nome: $nome, conta: $conta}';
  }
}
