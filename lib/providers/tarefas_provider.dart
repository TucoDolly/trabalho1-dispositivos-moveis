import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../util/db.dart';

class TarefasProvider with ChangeNotifier {
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => [..._tarefas];

  Future<void> carregarTarefas() async {
    final db = await DbUtil.instance.database;
    final dados = await db.query('tarefas');
    _tarefas = dados.map((map) => Tarefa.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    final db = await DbUtil.instance.database;
    final id = await db.insert('tarefas', tarefa.toMap());
    tarefa.id = id;
    _tarefas.add(tarefa);
    notifyListeners();
  }

  Future<void> atualizarTarefa(Tarefa tarefa) async {
    final db = await DbUtil.instance.database;
    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
    final index = _tarefas.indexWhere((t) => t.id == tarefa.id);
    if (index >= 0) {
      _tarefas[index] = tarefa;
      notifyListeners();
    }
  }

  Future<void> removerTarefa(int id) async {
    final db = await DbUtil.instance.database;
    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
    _tarefas.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}