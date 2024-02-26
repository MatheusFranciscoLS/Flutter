class Tarefa {
  String descricao;
  bool concluida;
  DateTime dataHora;

  Tarefa(this.descricao, this.concluida) : dataHora = DateTime.now();
}
