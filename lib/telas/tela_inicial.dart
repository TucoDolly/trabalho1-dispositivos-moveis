import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarefas_provider.dart';
import '../models/tarefa.dart';
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
        child: Text('Nenhuma tarefa encontrada.'),
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
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Tarefas'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Todas'),
              Tab(icon: Icon(Icons.check_circle), text: 'Feitas'),
              Tab(icon: Icon(Icons.radio_button_unchecked), text: 'Fazer'),
              Tab(icon: Icon(Icons.event_available), text: 'Em dia'),
              Tab(icon: Icon(Icons.star), text: 'Importante'),
              Tab(icon: Icon(Icons.star_border), text: 'Comuns'),
              Tab(icon: Icon(Icons.warning_amber), text: 'Atrasos'),
            ],
          ),
        ),
        body: Consumer<TarefasProvider>(
          builder: (ctx, tarefasProvider, child) {
            final tarefas = tarefasProvider.tarefas.toList();

            tarefas.sort((a, b) {
              int comparacaoData = a.dataPrevista.compareTo(b.dataPrevista);
              if (comparacaoData != 0) {
                return comparacaoData;
              }
              return a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase());
            });

            return TabBarView(
              children: [
                _buildLista(tarefas),
                _buildLista(tarefas.where((t) => t.realizada).toList()),
                _buildLista(tarefas.where((t) => !t.realizada).toList()),
                _buildLista(tarefas.where((t) => !_isAtrasada(t)).toList()),
                _buildLista(tarefas.where((t) => t.importante).toList()),
                _buildLista(tarefas.where((t) => !t.importante).toList()),
                _buildLista(tarefas.where((t) => _isAtrasada(t)).toList()),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/cadastro');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}