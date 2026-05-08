import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas_provider.dart';

class CardTarefa extends StatelessWidget {
  final Tarefa tarefa;

  const CardTarefa({super.key, required this.tarefa});

  @override
  Widget build(BuildContext context) {
    
    final dataAtual = DateTime.now();
    final hoje = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
    final dataTarefa = DateTime(tarefa.dataPrevista.year, tarefa.dataPrevista.month, tarefa.dataPrevista.day);
    final isAtrasada = dataTarefa.isBefore(hoje) && !tarefa.realizada;

    return Dismissible(
      key: ValueKey(tarefa.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        Provider.of<TarefasProvider>(context, listen: false).removerTarefa(tarefa.id!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/detalhes',
              arguments: tarefa,
            );
          },
          leading: Icon(
            tarefa.realizada ? Icons.check_circle : (tarefa.importante ? Icons.star : Icons.star_border),
            color: tarefa.realizada ? Colors.green : (tarefa.importante ? Colors.amber : Colors.grey),
            size: 30,
          ),
          title: Text(
            tarefa.titulo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: tarefa.realizada ? TextDecoration.lineThrough : null,
              color: isAtrasada ? Colors.red : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categoria: ${tarefa.categoria}'),
              if (isAtrasada)
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    '⚠️ Tarefa Atrasada',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${tarefa.dataPrevista.day}/${tarefa.dataPrevista.month}/${tarefa.dataPrevista.year}'),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/cadastro',
                    arguments: tarefa,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}