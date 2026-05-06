class Tarefa {
  int? id;
  final String titulo;
  final String descricao;
  final DateTime dataPrevista;
  final bool importante;
  final String categoria;
  final bool realizada;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataPrevista,
    required this.importante,
    required this.categoria,
    this.realizada = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataPrevista': dataPrevista.toIso8601String(),
      'importante': importante ? 1 : 0,
      'categoria': categoria,
      'realizada': realizada ? 1 : 0,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      dataPrevista: DateTime.parse(map['dataPrevista']),
      importante: map['importante'] == 1,
      categoria: map['categoria'],
      realizada: map['realizada'] == 1,
    );
  }
}