import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas_provider.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  void initState() {
    super.initState();
    Provider.of<TarefasProvider>(context, listen: false).carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
      ),
      body: const Center(
        child: Text('Lista de tarefas virá aqui'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}