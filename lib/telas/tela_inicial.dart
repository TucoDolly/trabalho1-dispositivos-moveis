import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas_provider.dart';
import '../models/tarefa.dart';
import 'tela_cadastro.dart';
import '../componentes/card_tarefa.dart';

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

  bool _isAtrasada(Tarefa tarefa) {
    final dataAtual = DateTime.now();
    final hoje = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
    final dataTarefa = DateTime(tarefa.dataPrevista.year, tarefa.dataPrevista.month, tarefa.dataPrevista.day);
    return dataTarefa.isBefore(hoje) && !tarefa.realizada;
  }

  Widget _buildLista(List<Tarefa> tarefas) {
    if (tarefas.isEmpty) {
      return const Center(
        child: Text('Nenhuma tarefa encontrada neste filtro.'),
      );
    }
    return ListView.builder(
      itemCount: tarefas.length,
      itemBuilder: (ctx, i) {
        return CardTarefa(tarefa: tarefas[i]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Tarefas'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.zero,
            labelStyle: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 12.5),
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Todas'),
              Tab(icon: Icon(Icons.star), text: 'Importantes'),
              Tab(icon: Icon(Icons.warning), text: 'Atrasadas'),
              Tab(icon: Icon(Icons.check_circle), text: 'Prontas'),
            ],
          ),
        ),
        body: Consumer<TarefasProvider>(
          builder: (ctx, tarefasProvider, child) {
            final todas = tarefasProvider.tarefas.toList();
            final importantes = tarefasProvider.tarefas.where((t) => t.importante && !t.realizada).toList();
            final atrasadas = tarefasProvider.tarefas.where((t) => _isAtrasada(t)).toList();
            final realizadas = tarefasProvider.tarefas.where((t) => t.realizada).toList();

            return TabBarView(
              children: [
                _buildLista(todas),
                _buildLista(importantes),
                _buildLista(atrasadas),
                _buildLista(realizadas),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TelaCadastro(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}