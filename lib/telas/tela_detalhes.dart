import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarefa.dart';
import '../providers/tarefas_provider.dart';

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = ModalRoute.of(context)!.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${tarefa.id}',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 10),
              Text(
                tarefa.titulo,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 30),
              const Text(
                'Descrição:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                tarefa.descricao,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 10),
                  Text('Data: ${tarefa.dataPrevista.day}/${tarefa.dataPrevista.month}/${tarefa.dataPrevista.year}'),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.category, size: 20),
                  const SizedBox(width: 10),
                  Text('Categoria: ${tarefa.categoria}'),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: tarefa.realizada 
                    ? null 
                    : () {
                        final tarefaAtualizada = Tarefa(
                          id: tarefa.id,
                          titulo: tarefa.titulo,
                          descricao: tarefa.descricao,
                          dataPrevista: tarefa.dataPrevista,
                          importante: tarefa.importante,
                          categoria: tarefa.categoria,
                          realizada: true,
                        );
                        Provider.of<TarefasProvider>(context, listen: false).atualizarTarefa(tarefaAtualizada);
                        Navigator.of(context).pop();
                      },
                  icon: const Icon(Icons.check),
                  label: Text(tarefa.realizada ? 'Tarefa Realizada' : 'Marcar como Realizada'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tarefa.realizada ? Colors.grey : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}