class Tarefa {
  int? id;
  String titulo;
  String descricao;
  DateTime dataPrevista;
  bool importante;
  bool realizada;
  String categoria;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.dataPrevista,
    this.importante = false,
    this.realizada = false,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'dataPrevista': dataPrevista.toIso8601String(),
      'importante': importante ? 1 : 0,
      'realizada': realizada ? 1 : 0,
      'categoria': categoria,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      dataPrevista: DateTime.parse(map['dataPrevista']),
      importante: map['importante'] == 1,
      realizada: map['realizada'] == 1,
      categoria: map['categoria'],
    );
  }
}